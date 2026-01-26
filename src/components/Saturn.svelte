<script lang="ts">
    import { onMount } from "svelte";
    import * as THREE from "three";
    import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js";
    import { EffectComposer } from "three/examples/jsm/postprocessing/EffectComposer.js";
    import { RenderPass } from "three/examples/jsm/postprocessing/RenderPass.js";
    import { UnrealBloomPass } from "three/examples/jsm/postprocessing/UnrealBloomPass.js";

    let canvas: HTMLCanvasElement;

    onMount(() => {
        // --- Scene Setup ---
        const scene = new THREE.Scene();
        scene.background = new THREE.Color(0x000000);

        const camera = new THREE.PerspectiveCamera(
            60,
            window.innerWidth / window.innerHeight,
            0.1,
            2000,
        );
        camera.position.set(0, 5, 25);

        const renderer = new THREE.WebGLRenderer({
            canvas,
            antialias: false, // ToneMapping handles AA better usually, or we depend on high pixel ratio
            alpha: true,
            powerPreference: "high-performance",
        });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
        renderer.toneMapping = THREE.ACESFilmicToneMapping;
        renderer.toneMappingExposure = 1.0;
        renderer.shadowMap.enabled = true;
        renderer.shadowMap.type = THREE.PCFSoftShadowMap;

        // Ensure canvas is interactive
        canvas.style.touchAction = "none";
        canvas.style.pointerEvents = "auto";
        canvas.style.cursor = "grab";

        const controls = new OrbitControls(camera, canvas);
        controls.enableDamping = true;
        controls.dampingFactor = 0.05;
        controls.minDistance = 10;
        controls.maxDistance = 100;
        controls.autoRotate = true;
        controls.autoRotateSpeed = 0.5;

        canvas.addEventListener(
            "mousedown",
            () => (canvas.style.cursor = "grabbing"),
        );
        canvas.addEventListener(
            "mouseup",
            () => (canvas.style.cursor = "grab"),
        );

        // --- Lighting ---
        const ambientLight = new THREE.AmbientLight(0xffffff, 0.2); // Increased from 0.02
        scene.add(ambientLight);

        const sunLight = new THREE.PointLight(0xffffff, 3.0, 0, 0.5); // Increased from 2.5
        sunLight.position.set(100, 20, 50);
        // We still keep standard shadow map for moons, but will do custom for rings
        sunLight.castShadow = true;
        sunLight.shadow.mapSize.width = 1024;
        sunLight.shadow.mapSize.height = 1024;
        scene.add(sunLight);

        // --- Post Processing ---
        const renderScene = new RenderPass(scene, camera);

        const bloomPass = new UnrealBloomPass(
            new THREE.Vector2(window.innerWidth, window.innerHeight),
            0.5, // Strength
            0.4, // Radius
            0.85, // Threshold
        );

        const composer = new EffectComposer(renderer);
        composer.addPass(renderScene);
        composer.addPass(bloomPass);

        // --- Starfield ---
        const starCount = 5000;
        const starGeo = new THREE.BufferGeometry();
        const starPos = new Float32Array(starCount * 3);
        const starColors = new Float32Array(starCount * 3);

        for (let i = 0; i < starCount; i++) {
            const r = 200 + Math.random() * 800; // Far background
            const theta = 2 * Math.PI * Math.random();
            const phi = Math.acos(2 * Math.random() - 1);
            starPos[i * 3] = r * Math.sin(phi) * Math.cos(theta);
            starPos[i * 3 + 1] = r * Math.sin(phi) * Math.sin(theta);
            starPos[i * 3 + 2] = r * Math.cos(phi);

            const shade = 0.8 + Math.random() * 0.2;
            starColors[i * 3] = shade;
            starColors[i * 3 + 1] = shade * (0.9 + Math.random() * 0.1);
            starColors[i * 3 + 2] = shade * (0.8 + Math.random() * 0.2);
        }
        starGeo.setAttribute("position", new THREE.BufferAttribute(starPos, 3));
        starGeo.setAttribute("color", new THREE.BufferAttribute(starColors, 3));
        const starMat = new THREE.PointsMaterial({
            size: 0.5,
            vertexColors: true,
        });
        const stars = new THREE.Points(starGeo, starMat);
        scene.add(stars);

        // --- Saturn Planet (Advanced Shader) ---
        const planetGeo = new THREE.SphereGeometry(5, 128, 128);

        const vertexShader = `
            varying vec2 vUv;
            varying vec3 vNormal;
            varying vec3 vViewPosition;
            varying vec3 vWorldPosition;

            void main() {
                vUv = uv;
                vNormal = normalize(normalMatrix * normal);
                vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
                vViewPosition = -mvPosition.xyz;
                vWorldPosition = (modelMatrix * vec4(position, 1.0)).xyz;
                gl_Position = projectionMatrix * mvPosition;
            }
        `;

        const fragmentShader = `
            uniform vec3 uSunPosition;
            uniform vec3 uColorA;
            uniform vec3 uColorB;
            uniform vec3 uColorC;
            
            varying vec2 vUv;
            varying vec3 vNormal;
            varying vec3 vViewPosition;
            varying vec3 vWorldPosition;

            // Simple noise function
            float hash(float n) { return fract(sin(n) * 43758.5453123); }
            float noise(float p) {
                float fl = floor(p);
                float fc = fract(p);
                return mix(hash(fl), hash(fl + 1.0), fc);
            }

            void main() {
                float y = vUv.y;
                float n = noise(y * 20.0) * 0.1;
                
                vec3 bands = mix(uColorA, uColorB, 0.5 + 0.5 * sin(y * 50.0 + n));
                bands = mix(bands, uColorC, 0.5 + 0.5 * cos(y * 20.0));
                
                vec3 normal = normalize(vNormal);
                vec3 sunDir = normalize(uSunPosition - vWorldPosition); 
                float diff = max(dot(normal, sunDir), 0.0);
                
                // --- CUSTOM RING SHADOW CALCULATION ---
                // Trace Ray from Surface towards Sun
                // Intersection with Plane Y=0
                // Ray: P + t*L
                // Plane: y = 0
                // (Py + t*Ly) = 0 => t = -Py / Ly
                // Intersection Point I = P + t*L
                
                float shadowFactor = 1.0;
                
                // Only cast shadow if light is coming from "above" or "below" ring plane relative to surface point
                // And only if surface point is on the side away from sun relative to plane? No, just simple raycast
                
                if (diff > 0.0) {
                     float t = -vWorldPosition.y / sunDir.y;
                     if (t > 0.0) {
                         // There is an intersection with the plane in the direction of the light
                         vec3 intersection = vWorldPosition + sunDir * t;
                         float r = length(intersection.xz);
                         
                         // Check if radius is within ring bands
                         // Ring C: 6.0 - 7.3
                         // Ring B: 7.4 - 9.0
                         // Ring A: 9.4 - 11.0
                         
                         // Soften edges slightly with width
                         // Simple binary check for now
                         bool inRing = (r > 6.0 && r < 7.3) || (r > 7.4 && r < 9.0) || (r > 9.4 && r < 11.0);
                         
                         if (inRing) {
                             shadowFactor = 0.4; // Darken
                         }
                         
                         // Cassini division (light passes through)
                         if (r > 9.0 && r < 9.4) {
                             shadowFactor = 1.0; 
                         }
                     }
                }

                // Atmosphere
                vec3 viewDir = normalize(vViewPosition);
                float fresnel = pow(1.0 - dot(normal, viewDir), 2.5);
                vec3 atmosphere = vec3(0.4, 0.5, 0.8) * fresnel * 0.6;

                // Combine
                vec3 finalColor = bands * diff * shadowFactor + atmosphere;
                
                // Add Ambient
                finalColor += bands * 0.05;

                gl_FragColor = vec4(finalColor, 1.0);
            }
        `;

        const planetMat = new THREE.ShaderMaterial({
            uniforms: {
                uSunPosition: { value: sunLight.position },
                uColorA: { value: new THREE.Color(0xdcbfa5) },
                uColorB: { value: new THREE.Color(0xbf9b78) },
                uColorC: { value: new THREE.Color(0xe6d4b5) },
            },
            vertexShader,
            fragmentShader,
        });

        const saturn = new THREE.Mesh(planetGeo, planetMat);
        // We disable standard receive shadow because we calculate it manually for rings
        saturn.receiveShadow = false;
        saturn.castShadow = true;
        scene.add(saturn);

        // --- Rings (InstancedMesh) ---
        const particlesCount = 25000;
        const ringGeo = new THREE.TetrahedronGeometry(0.05, 0);

        // Custom Shader for Rings to handle Planet Shadow (Eclipse)
        const ringMat = new THREE.MeshStandardMaterial({
            color: 0xcfbca2,
            roughness: 0.8,
            metalness: 0.1,
        });

        // Inject Planet Shadow Logic into Standard Material
        ringMat.onBeforeCompile = (shader) => {
            shader.uniforms.uSunPos = { value: sunLight.position };
            shader.uniforms.uPlanetPos = { value: new THREE.Vector3(0, 0, 0) };
            shader.uniforms.uPlanetRadius = { value: 5.0 };

            shader.fragmentShader =
                `
                uniform vec3 uSunPos;
                uniform vec3 uPlanetPos;
                uniform float uPlanetRadius;
                varying vec3 vWorldPosition;
            ` + shader.fragmentShader;

            shader.fragmentShader = shader.fragmentShader.replace(
                "#include <dithering_fragment>",
                `
                #include <dithering_fragment>
                
                // Planet Shadow Calculation
                // Ray from Fragment to Sun
                // Check intersection with Sphere (Planet)
                
                vec3 lightDir = normalize(uSunPos - vWorldPosition);
                vec3 L = vWorldPosition - uPlanetPos;
                float tca = dot(L, -lightDir);
                // If tca < 0, light is behind us, but for shadow casting object is between light and us...
                // Wait, we are checking if planet blocks sun.
                // Ray origin: P, Dir: L (to sun)
                // Sphere at C, radius R.
                
                // Simple Sphere Trace
                // Center C = 0,0,0
                // Ray Origin O = vWorldPos
                // Ray Dir D = normalize(SunPos - vWorldPos)
                
                // Vector to Center
                vec3 oc = uPlanetPos - vWorldPosition;
                float t = dot(oc, lightDir);
                
                // If t > 0, the sphere is in front of us (towards the light)
                if (t > 0.0) {
                    vec3 p = vWorldPosition + lightDir * t;
                    float dist = length(p - uPlanetPos);
                    if (dist < uPlanetRadius) {
                        // In shadow!
                        gl_FragColor.rgb *= 0.25; // Softened shadow (was 0.1)
                    }
                }
                `,
            );

            // We need vWorldPosition from vertex shader
            shader.vertexShader =
                `
                varying vec3 vWorldPosition;
            ` + shader.vertexShader;

            shader.vertexShader = shader.vertexShader.replace(
                "#include <worldpos_vertex>",
                `
                #include <worldpos_vertex>
                vWorldPosition = (modelMatrix * vec4(transformed, 1.0)).xyz;
                `,
            );
        };

        const ringMesh = new THREE.InstancedMesh(
            ringGeo,
            ringMat,
            particlesCount,
        );
        ringMesh.instanceMatrix.setUsage(THREE.DynamicDrawUsage);
        ringMesh.castShadow = true;
        ringMesh.receiveShadow = true; // Still receive self shadows via standard map if possible

        const dummy = new THREE.Object3D();
        const color = new THREE.Color();

        for (let i = 0; i < particlesCount; i++) {
            const seed = Math.random();
            let r = 0;

            if (seed < 0.2) {
                // C Ring
                r = 6.0 + Math.random() * 1.3;
            } else if (seed < 0.65) {
                // B Ring
                r = 7.4 + Math.random() * 1.6;
            } else {
                // A Ring
                r = 9.4 + Math.random() * 1.6;
            }

            const angle = Math.random() * Math.PI * 2;
            const h = (Math.random() - 0.5) * 0.15; // Slightly thicker

            dummy.position.set(Math.cos(angle) * r, h, Math.sin(angle) * r);
            dummy.rotation.set(
                Math.random() * Math.PI,
                Math.random() * Math.PI,
                Math.random() * Math.PI,
            );
            const scale = 0.5 + Math.random() * 1.2;
            dummy.scale.set(scale, scale, scale);
            dummy.updateMatrix();
            ringMesh.setMatrixAt(i, dummy.matrix);

            if (r < 7.4) {
                ringMesh.setColorAt(i, color.setHex(0xaa9988)); // Much lighter (was 0x655544)
            } else if (r > 9.0 && r < 9.4) {
                ringMesh.setColorAt(i, color.setHex(0x222222)); // Gap (was 0x111111)
            } else {
                const varColor = 0.2 * Math.random();
                ringMesh.setColorAt(
                    i,
                    color.setRGB(
                        0.95 + varColor,
                        0.9 + varColor,
                        0.8 + varColor,
                    ),
                ); // Brighter
            }
        }

        ringMesh.instanceMatrix.needsUpdate = true;

        scene.add(ringMesh);

        // --- Shepherd Moons ---
        const createMoon = (
            size: number,
            distance: number,
            colorHex: number,
            speed: number,
        ) => {
            const moonGeo = new THREE.SphereGeometry(size, 32, 32);
            const moonMat = new THREE.MeshStandardMaterial({ color: colorHex });
            const moon = new THREE.Mesh(moonGeo, moonMat);
            moon.castShadow = true;
            moon.receiveShadow = true;

            const angle = Math.random() * Math.PI * 2;
            moon.position.set(
                Math.cos(angle) * distance,
                0,
                Math.sin(angle) * distance,
            );

            scene.add(moon);
            return { mesh: moon, distance, speed, angle };
        };

        const moons = [
            createMoon(0.15, 12.5, 0xffffff, 0.5), // Enceladus
            createMoon(0.4, 20.0, 0xe3a857, 0.2), // Titan
            createMoon(0.1, 11.5, 0x888888, 0.7), // Mimas
        ];

        // --- Animation Loop ---
        const clock = new THREE.Clock();
        let animationId: number;

        const animate = () => {
            animationId = requestAnimationFrame(animate);
            const delta = clock.getDelta();

            // Rotate Saturn
            saturn.rotation.y += 0.02 * delta;

            // Rotate Rings
            ringMesh.rotation.y += 0.015 * delta;

            // Animate Moons
            moons.forEach((moon) => {
                moon.angle += moon.speed * delta * 0.5;
                moon.mesh.position.x = Math.cos(moon.angle) * moon.distance;
                moon.mesh.position.z = Math.sin(moon.angle) * moon.distance;
                moon.mesh.rotation.y += delta;
            });

            controls.update();
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
            planetGeo.dispose();
            planetMat.dispose();
            ringGeo.dispose();
            ringMat.dispose();
            stars.geometry.dispose();
            stars.material.dispose();
        };
    });
</script>

<canvas bind:this={canvas} class="block w-full h-full bg-black"></canvas>

<style>
    :global(body) {
        margin: 0;
        overflow: hidden;
        background-color: #000;
    }
</style>
