<script lang="ts">
    import { onMount, tick } from "svelte";
    import * as THREE from "three";
    import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js";
    import { EffectComposer } from "three/examples/jsm/postprocessing/EffectComposer.js";
    import { RenderPass } from "three/examples/jsm/postprocessing/RenderPass.js";
    import { UnrealBloomPass } from "three/examples/jsm/postprocessing/UnrealBloomPass.js";

    let canvas: HTMLCanvasElement;

    // --- Shaders ---

    // 1. Surface Shader (Animated Plasma)
    const SurfaceVertexShader = `
        varying vec2 vUv;
        varying vec3 vNormal;
        varying vec3 vPos;
        void main() {
            vUv = uv;
            vNormal = normalize(normalMatrix * normal);
            vPos = position;
            gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
    `;

    const SurfaceFragmentShader = `
        uniform float uTime;
        varying vec2 vUv;
        varying vec3 vNormal;
        varying vec3 vPos;

        // Simplex Noise
        vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
        vec4 mod289(vec4 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
        vec4 permute(vec4 x) { return mod289(((x*34.0)+1.0)*x); }
        vec4 taylorInvSqrt(vec4 r) { return 1.79284291400159 - 0.85373472095314 * r; }

        float snoise(vec3 v) {
            const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
            const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);
            vec3 i  = floor(v + dot(v, C.yyy) );
            vec3 x0 = v - i + dot(i, C.xxx) ;
            vec3 g = step(x0.yzx, x0.xyz);
            vec3 l = 1.0 - g;
            vec3 i1 = min( g.xyz, l.zxy );
            vec3 i2 = max( g.xyz, l.zxy );
            vec3 x1 = x0 - i1 + C.xxx;
            vec3 x2 = x0 - i2 + C.yyy; 
            vec3 x3 = x0 - D.yyy;      
            i = mod289(i); 
            vec4 p = permute( permute( permute( 
                        i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
                        + i.y + vec4(0.0, i1.y, i2.y, 1.0 )) 
                        + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));
            float n_ = 0.142857142857; 
            vec3  ns = n_ * D.wyz - D.xzx;
            vec4 j = p - 49.0 * floor(p * ns.z * ns.z);  
            vec4 x_ = floor(j * ns.z);
            vec4 y_ = floor(j - 7.0 * x_ );    
            vec4 x = x_ *ns.x + ns.yyyy;
            vec4 y = y_ *ns.x + ns.yyyy;
            vec4 h = 1.0 - abs(x) - abs(y);
            vec4 b0 = vec4( x.xy, y.xy );
            vec4 b1 = vec4( x.zw, y.zw );
            vec4 s0 = floor(b0)*2.0 + 1.0;
            vec4 s1 = floor(b1)*2.0 + 1.0;
            vec4 sh = -step(h, vec4(0.0));
            vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
            vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;
            vec3 p0 = vec3(a0.xy,h.x);
            vec3 p1 = vec3(a0.zw,h.y);
            vec3 p2 = vec3(a1.xy,h.z);
            vec3 p3 = vec3(a1.zw,h.w);
            vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
            p0 *= norm.x; p1 *= norm.y; p2 *= norm.z; p3 *= norm.w;
            vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
            m = m * m;
            return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1), dot(p2,x2), dot(p3,x3) ) );
        }

        void main() {
            // Rapid surface movement
            float n = snoise(vPos * 3.0 + vec3(0.0, uTime * 2.0, 0.0));
            // Layering noise
            n += 0.5 * snoise(vPos * 8.0 - vec3(uTime * 5.0, 0.0, 0.0));

            // Hotspots at poles (y-axis is Up)
            float pole = smoothstep(0.5, 1.0, abs(vPos.y)); 
            
            // Base Color (Blue)
            vec3 coolColor = vec3(0.0, 0.2, 0.8);
            vec3 hotColor = vec3(0.5, 0.8, 1.0);
            vec3 poleColor = vec3(1.0, 1.0, 1.5); // Super bright white

            // Mix based on noise
            vec3 finalColor = mix(coolColor, hotColor, n * 0.5 + 0.5);

            // Add pole brightness
            finalColor = mix(finalColor, poleColor, pole * 0.8); 
            
            // Rim lighting
            vec3 viewDir = normalize(cameraPosition - vPos); // Approximation, not perfect in local space but close enough for small object
            // Actually stick to normal.z ish if in eye space... but let's use standard fresnel hack
            // Here we don't have cameraPosition uniform passed in easily without tracking it...
            // Let's assume view is somewhat aligned or use vNormal.
            
            gl_FragColor = vec4(finalColor, 1.0);
        }
    `;

    // 2. Magnetic Particle Shader (Flow)
    const ParticleVertexShader = `
        attribute float aOffset; // Start position along curve (0 to 1)
        attribute float aSpeed;
        
        uniform float uTime;
        uniform vec3 uPath[50]; // Hardcoded curve points? No, too heavy. 
        // Better: We just use simple sine wave math or we animate uv along a tube.
        
        // Alternative: Use Points and animate them in loop in JS? No, performance.
        // Let's use a simple trick: Map the "Line" as a Tube, but texture it with moving dots.
        
        varying vec2 vUv;
        void main() {
            vUv = uv;
            gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
    `;

    // Changing approach: Use ShaderMaterial on the TUBE itself to simulate particles.
    const MagneticFlowFragmentShader = `
        uniform float uTime;
        uniform vec3 uColor;
        varying vec2 vUv;

        void main() {
            // vUv.x is around the tube, vUv.y is along the length (0 to 1)
            
            // Create "dots" flowing along y
            float flow = fract(vUv.y * 10.0 - uTime * 2.0); // 10 segments, moving fast
            
            // Make them small dots
            float dot = smoothstep(0.0, 0.2, flow) * smoothstep(0.4, 0.2, flow);
            
            // Fade out near poles (ends of tube)
            float alpha = dot * smoothstep(0.0, 0.1, vUv.y) * smoothstep(1.0, 0.9, vUv.y);
            
            gl_FragColor = vec4(uColor, alpha);
        }
    `;

    // 3. Gravitational Lensing (Simple Refraction Sphere)
    // We can imitate this with a transparent sphere that distorts what's behind it.
    // Real-time refraction requires a background texture capture, which is heavy.
    // Lighter approach: Use a simple shader that just warps the background color slightly or just looks cool/glassy.
    // For now, let's skip full refraction and make a "Gravity Sphere" halo.

    onMount(() => {
        // --- Scene Setup ---
        const scene = new THREE.Scene();
        scene.background = new THREE.Color(0x020205);
        scene.fog = new THREE.FogExp2(0x020205, 0.02);

        const camera = new THREE.PerspectiveCamera(
            60,
            window.innerWidth / window.innerHeight,
            0.1,
            1000,
        );
        camera.position.set(0, 2, 8);

        const renderer = new THREE.WebGLRenderer({
            canvas,
            antialias: false,
            powerPreference: "high-performance",
            alpha: true,
        });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
        renderer.toneMapping = THREE.ACESFilmicToneMapping;
        renderer.toneMappingExposure = 1.0;

        // Interaction
        canvas.style.touchAction = "none";
        canvas.style.pointerEvents = "auto";
        canvas.style.cursor = "grab";

        const controls = new OrbitControls(camera, canvas);
        controls.enableDamping = true;
        controls.dampingFactor = 0.05;
        controls.minDistance = 3;
        controls.maxDistance = 20;
        controls.enablePan = false;

        canvas.addEventListener(
            "mousedown",
            () => (canvas.style.cursor = "grabbing"),
        );
        canvas.addEventListener(
            "mouseup",
            () => (canvas.style.cursor = "grab"),
        );

        // --- Post Processing ---
        const renderPass = new RenderPass(scene, camera);
        const bloomPass = new UnrealBloomPass(
            new THREE.Vector2(window.innerWidth, window.innerHeight),
            2.5, // High strength for that blinding pulsar look
            0.5,
            0.8,
        );

        const composer = new EffectComposer(renderer);
        composer.addPass(renderPass);
        composer.addPass(bloomPass);

        // --- Starfield ---
        const starGeo = new THREE.BufferGeometry();
        const starCount = 4000;
        const posArray = new Float32Array(starCount * 3);
        const sizesArray = new Float32Array(starCount);
        for (let i = 0; i < starCount; i++) {
            const i3 = i * 3;
            posArray[i3] = (Math.random() - 0.5) * 150;
            posArray[i3 + 1] = (Math.random() - 0.5) * 150;
            posArray[i3 + 2] = (Math.random() - 0.5) * 150;
            sizesArray[i] = Math.random();
        }
        starGeo.setAttribute(
            "position",
            new THREE.BufferAttribute(posArray, 3),
        );
        starGeo.setAttribute("size", new THREE.BufferAttribute(sizesArray, 1));

        // Simple star shader to make them twinkle maybe? For now standard point material
        const starMat = new THREE.PointsMaterial({
            size: 0.1,
            color: 0xffffff,
        });
        const stars = new THREE.Points(starGeo, starMat);
        scene.add(stars);

        // --- Neutron Star Group ---
        const neutronStarGroup = new THREE.Group();
        // Dynamic tilt
        neutronStarGroup.rotation.z = Math.PI / 6;
        neutronStarGroup.rotation.x = Math.PI / 8;
        scene.add(neutronStarGroup);

        // 1. DYNAMIC SURFACE
        const starRadius = 1;
        const geometry = new THREE.SphereGeometry(starRadius, 128, 128); // High res for vertex displacement if we want

        const surfaceMaterial = new THREE.ShaderMaterial({
            uniforms: {
                uTime: { value: 0 },
            },
            vertexShader: SurfaceVertexShader,
            fragmentShader: SurfaceFragmentShader,
        });

        const starMesh = new THREE.Mesh(geometry, surfaceMaterial);
        neutronStarGroup.add(starMesh);

        // Add a "Halo" glow
        const glowGeo = new THREE.SphereGeometry(starRadius * 1.2, 64, 64);
        const glowMat = new THREE.ShaderMaterial({
            uniforms: {
                c: { value: 0.2 },
                p: { value: 4.0 },
                glowColor: { value: new THREE.Color(0x00aaff) },
                viewVector: { value: camera.position },
            },
            vertexShader: `
                uniform vec3 viewVector;
                uniform float c;
                uniform float p;
                varying float intensity;
                void main() {
                    vec3 vNormal = normalize(normalMatrix * normal);
                    vec3 vNormel = normalize(normalMatrix * viewVector);
                    intensity = pow(c - dot(vNormal, vNormel), p);
                    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
                }
            `,
            fragmentShader: `
                uniform vec3 glowColor;
                varying float intensity;
                void main() {
                    vec3 glow = glowColor * intensity;
                    gl_FragColor = vec4(glow, 1.0);
                }
            `,
            side: THREE.BackSide,
            blending: THREE.AdditiveBlending,
            transparent: true,
            depthWrite: false,
        });
        const glowMesh = new THREE.Mesh(glowGeo, glowMat);
        // neutronStarGroup.add(glowMesh); // Disabled as it conflicts with bloom a bit or needs tweaking

        // 2. MAGNETIC FLUX LINES (Flowing Particles)
        const magneticGroup = new THREE.Group();
        neutronStarGroup.add(magneticGroup);

        const flowMaterial = new THREE.ShaderMaterial({
            uniforms: {
                uTime: { value: 0 },
                uColor: { value: new THREE.Color(0x00ffff) },
            },
            vertexShader: ParticleVertexShader,
            fragmentShader: MagneticFlowFragmentShader,
            transparent: true,
            blending: THREE.AdditiveBlending,
            depthWrite: false,
            side: THREE.DoubleSide,
        });

        const numLines = 16;
        for (let i = 0; i < numLines; i++) {
            const angle = (i / numLines) * Math.PI * 2;
            const radius = 3.5 + Math.random() * 3;

            const curve = new THREE.CatmullRomCurve3([
                new THREE.Vector3(0, 0.4, 0),
                new THREE.Vector3(
                    Math.cos(angle) * radius * 0.5,
                    radius * 0.8,
                    Math.sin(angle) * radius * 0.5,
                ),
                new THREE.Vector3(
                    Math.cos(angle) * radius,
                    0,
                    Math.sin(angle) * radius,
                ),
                new THREE.Vector3(
                    Math.cos(angle) * radius * 0.5,
                    -radius * 0.8,
                    Math.sin(angle) * radius * 0.5,
                ),
                new THREE.Vector3(0, -0.4, 0),
            ]);

            const tubeGeo = new THREE.TubeGeometry(curve, 64, 0.03, 4, false); // Thin tubes
            const line = new THREE.Mesh(tubeGeo, flowMaterial);
            magneticGroup.add(line);
        }

        // 3. PULSAR BEAMS (Volumetric)
        const beamHeight = 18;
        const beamRadius = 2.0;

        const beamShader = {
            uniforms: {
                uTime: { value: 0 },
                uColor: { value: new THREE.Color(0xddffff) },
            },
            vertexShader: `
                varying vec3 vPos;
                varying vec2 vUv;
                void main() {
                    vUv = uv;
                    vPos = position;
                    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
                }
            `,
            fragmentShader: `
                uniform float uTime;
                uniform vec3 uColor;
                varying vec3 vPos;
                varying vec2 vUv;

                void main() {
                    // Beam intensity
                    float intensity = pow(1.0 - vUv.y, 2.0); 
                    float dist = abs(vPos.y); 
                    
                    // Core is brighter
                    float core = 1.0 - smoothstep(0.0, 1.0, abs(vPos.x) * 2.0);
                    
                    gl_FragColor = vec4(uColor, intensity * 0.4 * core); 
                }
            `,
            side: THREE.DoubleSide,
            transparent: true,
            depthWrite: false,
            blending: THREE.AdditiveBlending,
        };
        const beamMat = new THREE.ShaderMaterial(beamShader);

        const beamGeoUp = new THREE.ConeGeometry(
            beamRadius,
            beamHeight,
            64,
            1,
            true,
        );
        beamGeoUp.translate(0, beamHeight / 2, 0);
        const beamUp = new THREE.Mesh(beamGeoUp, beamMat);

        const beamGeoDown = new THREE.ConeGeometry(
            beamRadius,
            beamHeight,
            64,
            1,
            true,
        );
        beamGeoDown.rotateX(Math.PI);
        beamGeoDown.translate(0, -beamHeight / 2, 0);
        const beamDown = new THREE.Mesh(beamGeoDown, beamMat);

        neutronStarGroup.add(beamUp);
        neutronStarGroup.add(beamDown);

        // --- Animation Loop ---
        const clock = new THREE.Clock();
        let animationId: number;

        // Camera Shake State
        const originalCamPos = camera.position.clone();
        const noiseGen = new THREE.Vector3(); // Placeholder for shake noise

        const animate = () => {
            animationId = requestAnimationFrame(animate);
            const delta = clock.getDelta();
            const elapsed = clock.getElapsedTime();

            // 1. ROTATION (Fast!)
            // A real pulsar spins 100+ times a second. We'll do a visible fast spin.
            neutronStarGroup.rotation.y += delta * 12.0;

            // 2. UNIFORMS
            surfaceMaterial.uniforms.uTime.value = elapsed;
            flowMaterial.uniforms.uTime.value = elapsed;
            beamMat.uniforms.uTime.value = elapsed;

            // 3. CAMERA TRAUMA (Shake)
            // Calculate if the beam is pointing at the camera
            // The beam vector rotates with the group.
            // Beam vector in local space is (0, 1, 0) and (0, -1, 0) relative to group...
            // Wait, the group rotates around Y axis.
            // The beams are aligned with Y axis of the GROUP.
            // But the GROUP is tilted by rotation.z = PI/6 and rotation.x = PI/8.
            // So the beams are NOT pointing straight up in world space.

            // We need the world direction of the beams.
            const beamDir = new THREE.Vector3(0, 1, 0);
            beamDir.applyQuaternion(neutronStarGroup.quaternion); // Apply current rotation

            const camDir = camera.position.clone().normalize();

            // Dot product to see alignment
            // If dot > 0.95, it's pointing at us.
            const alignment = Math.abs(beamDir.dot(camDir)); // abs because two beams

            let shake = 0;
            if (alignment > 0.95) {
                shake = (alignment - 0.95) * 5.0; // 0 to 0.25 intensity
            }

            if (shake > 0) {
                camera.position.x =
                    originalCamPos.x + (Math.random() - 0.5) * shake * 0.5;
                camera.position.y =
                    originalCamPos.y + (Math.random() - 0.5) * shake * 0.5;
                camera.position.z =
                    originalCamPos.z + (Math.random() - 0.5) * shake * 0.5;
            } else {
                // Smooth return? Or just snap if delta is small enough.
                // Lerp back to avoid snapping
                camera.position.lerp(originalCamPos, 0.1);
            }

            controls.update(); // This might fight with camera shake if not careful.
            // Since controls updates camera position based on target and radius.
            // The shake applied above is overridden by controls.update() typically if controls.enableDamping is true.
            // Hack: apply shake to the LOOK AT target or after controls update?
            // Actually OrbitControls modifies position. If we modify position AFTER controls.update(), it works for that frame, but next frame controls resets it.
            // To do it properly with OrbitControls, we should shake center or just accept subtle fight.
            // Let's modify the controls target slightly instead?
            // Or just apply shake to scene.position! (Shake the world)
            if (shake > 0) {
                scene.position.x = (Math.random() - 0.5) * shake * 0.2;
                scene.position.y = (Math.random() - 0.5) * shake * 0.2;
            } else {
                scene.position.set(0, 0, 0);
            }

            composer.render();
        };

        animate();

        const onWindowResize = () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
            composer.setSize(window.innerWidth, window.innerHeight);
        };

        window.addEventListener("resize", onWindowResize);

        return () => {
            window.removeEventListener("resize", onWindowResize);
            cancelAnimationFrame(animationId);
            controls.dispose();
            renderer.dispose();
            composer.dispose();
            geometry.dispose();
            // Dispose other mats
        };
    });
</script>

<canvas bind:this={canvas} class="block w-full h-full text-white"></canvas>
