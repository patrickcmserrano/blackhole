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
        scene.background = new THREE.Color(0x050510); // Deep dark blue/purple bg
        scene.fog = new THREE.FogExp2(0x050510, 0.002);

        const camera = new THREE.PerspectiveCamera(
            60,
            window.innerWidth / window.innerHeight,
            0.1,
            2000,
        );
        camera.position.set(0, 0, 80);

        const renderer = new THREE.WebGLRenderer({
            canvas,
            antialias: false,
            powerPreference: "high-performance",
        });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
        renderer.toneMapping = THREE.ACESFilmicToneMapping;
        renderer.toneMappingExposure = 1.0;

        // Ensure canvas is interactive
        canvas.style.touchAction = "none";
        canvas.style.pointerEvents = "auto";
        canvas.style.cursor = "grab";

        // Controls: Allow flying through
        const controls = new OrbitControls(camera, canvas);
        controls.enableDamping = true;
        controls.dampingFactor = 0.05;
        controls.minDistance = 1; // Allow going inside
        controls.maxDistance = 200;
        controls.autoRotate = true;
        controls.autoRotateSpeed = 0.2;

        canvas.addEventListener(
            "mousedown",
            () => (canvas.style.cursor = "grabbing"),
        );
        canvas.addEventListener(
            "mouseup",
            () => (canvas.style.cursor = "grab"),
        );

        // --- Post Processing (Heavy Bloom for Gas Glow) ---
        const renderScene = new RenderPass(scene, camera);
        const bloomPass = new UnrealBloomPass(
            new THREE.Vector2(window.innerWidth, window.innerHeight),
            1.2, // Strength - Very high for nebula
            0.5, // Radius
            0.2, // Threshold - Bloom almost everything
        );

        const composer = new EffectComposer(renderer);
        composer.addPass(renderScene);
        composer.addPass(bloomPass);

        // --- Helper: Noise Function for Organic Shapes ---
        // Simple 3D noise translation
        function pseudoNoise(x: number, y: number, z: number) {
            return Math.sin(x * 0.1) * Math.cos(y * 0.1) * Math.sin(z * 0.1);
        }

        // --- Nebula Particles (Cloud Billboards) ---
        // Sculpting the "Pillars of Creation"
        // Three distinct columns.
        const particleCount = 12000; // Increased count for density (was 6000)
        const geometry = new THREE.BufferGeometry();
        const positions = [];
        const colors = [];
        const sizes = [];

        const colorGold = new THREE.Color(0xffcc33); // Sulfur/Dust (Lower)
        const colorCyan = new THREE.Color(0x00ffff); // Oxygen (Upper/Edges)
        const colorPink = new THREE.Color(0xff0066); // Hydrogen (Core)

        for (let i = 0; i < particleCount; i++) {
            let x = 0,
                y = 0,
                z = 0;
            let pillarId = 0;
            let heightPercent = 0;

            // We consciously construct 3 pillars
            const r = Math.random();

            if (r < 0.45) {
                // Left Pillar (Largest)
                // Tall, wide top
                pillarId = 1;
                const h = Math.random() * 60 - 20; // Height -20 to 40
                y = h;
                heightPercent = (h + 20) / 60;

                // Wiggle spine
                const curve = Math.sin(h * 0.1) * 3;

                // Radius varies with height (Head is wider)
                let radius = 4 + Math.random() * 4;
                if (h > 30) radius += 4; // Big head

                const angle = Math.random() * Math.PI * 2;
                const dist = Math.sqrt(Math.random()) * radius; // Uniform disk

                x = -20 + curve + Math.cos(angle) * dist;
                z = 0 + Math.sin(angle) * dist;
            } else if (r < 0.75) {
                // Middle Pillar
                pillarId = 2;
                const h = Math.random() * 50 - 25;
                y = h;
                heightPercent = (h + 25) / 50;

                const curve = Math.sin(h * 0.15) * 2;
                let radius = 3 + Math.random() * 3;

                const angle = Math.random() * Math.PI * 2;
                const dist = Math.sqrt(Math.random()) * radius;

                x = 0 + curve + Math.cos(angle) * dist;
                z = 5 + Math.sin(angle) * dist;
            } else {
                // Right Pillar (Smallest)
                pillarId = 3;
                const h = Math.random() * 40 - 30;
                y = h;
                heightPercent = (h + 30) / 40;

                let radius = 2.5 + Math.random() * 2.5;
                const angle = Math.random() * Math.PI * 2;
                const dist = Math.sqrt(Math.random()) * radius;

                x = 15 + Math.cos(angle) * dist;
                z = 2 + Math.sin(angle) * dist;
            }

            // Global Noise Distortion
            x += (Math.random() - 0.5) * 2;
            y += (Math.random() - 0.5) * 2;
            z += (Math.random() - 0.5) * 2;

            positions.push(x, y, z);

            // Color Logic (Hubble Style)
            // Bottom/Inside = Darker/Gold/Brown (Dust)
            // Top/Edges = Bright Cyan/Blue (Ionized Oxygen)

            const mixedColor = new THREE.Color();

            // Base gradient by height
            mixedColor.lerpColors(colorGold, colorCyan, heightPercent * 0.8);

            // Edges (Ionization front) are brighter/bluer
            // We don't have exact SDF, but we can approximate "edge" by distance from spine
            // But simple noise mix works well

            // Add some pink hydrogen pockets
            if (Math.random() > 0.8) {
                mixedColor.lerp(colorPink, 0.5);
            }

            // Brighten "heads" of pillars (Star formation zones)
            if (heightPercent > 0.9) {
                mixedColor.lerp(new THREE.Color(1, 1, 1), 0.5);
            }

            // Darken base for "Dusty" look
            if (heightPercent < 0.2) {
                mixedColor.multiplyScalar(0.6);
            }

            colors.push(mixedColor.r, mixedColor.g, mixedColor.b);

            // Size variation
            sizes.push(Math.random() * 12 + 6);
        }

        const posArray = new Float32Array(positions);
        const colArray = new Float32Array(colors);
        const sizeArray = new Float32Array(sizes);

        geometry.setAttribute(
            "position",
            new THREE.BufferAttribute(posArray, 3),
        );
        geometry.setAttribute("color", new THREE.BufferAttribute(colArray, 3));
        geometry.setAttribute("size", new THREE.BufferAttribute(sizeArray, 1));

        // Custom Shader for Soft Particles
        const material = new THREE.ShaderMaterial({
            uniforms: {
                pointTexture: {
                    value: new THREE.TextureLoader().load(
                        "https://threejs.org/examples/textures/sprites/spark1.png",
                    ),
                }, // Fallback/Procedural?
                // Let's generate a soft particle procedural texture in fragment shader to avoid external deps if possible,
                // OR use a simple distance fade.
            },
            vertexShader: `
                attribute float size;
                varying vec3 vColor;
                void main() {
                    vColor = color;
                    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
                    gl_PointSize = size * (300.0 / -mvPosition.z); // Scale by distance
                    gl_Position = projectionMatrix * mvPosition;
                }
            `,
            fragmentShader: `
                varying vec3 vColor;
                void main() {
                    // Soft circular particle
                    vec2 uv = gl_PointCoord.xy - 0.5;
                    float r = length(uv);
                    if (r > 0.5) discard;
                    
                    // Soft edge glow
                    float alpha = 1.0 - Smooth2(r); 
                    // Custom smooth curve
                    
                    // Simple radial gradient
                    float glow = 1.0 - (r * 2.0);
                    glow = pow(glow, 1.5);

                    gl_FragColor = vec4(vColor, glow * 0.4); // Low opacity for accumulation
                }
                
                float Smooth2(float x) { return x * x * (3.0 - 2.0 * x); }
            `,
            blending: THREE.AdditiveBlending,
            depthWrite: false,
            transparent: true,
            vertexColors: true,
        });

        const nebula = new THREE.Points(geometry, material);
        scene.add(nebula);

        // --- Stars (Young stars born in nebula) ---
        const starsGeo = new THREE.BufferGeometry();
        const starsPos = [];
        for (let i = 0; i < 500; i++) {
            starsPos.push(
                (Math.random() - 0.5) * 60,
                (Math.random() - 0.5) * 60,
                (Math.random() - 0.5) * 60,
            );
        }
        starsGeo.setAttribute(
            "position",
            new THREE.Float32BufferAttribute(starsPos, 3),
        );
        const starsMat = new THREE.PointsMaterial({
            color: 0xffffff,
            size: 0.8,
        });
        const stars = new THREE.Points(starsGeo, starsMat);
        scene.add(stars);

        // --- Animation ---
        const clock = new THREE.Clock();
        let animationId: number;

        const animate = () => {
            animationId = requestAnimationFrame(animate);
            const delta = clock.getDelta();

            // Slowly rotate the entire nebula
            nebula.rotation.y += 0.05 * delta;

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
            geometry.dispose();
            material.dispose();
        };
    });
</script>

<canvas bind:this={canvas} class="block w-full h-full bg-[#050510]"></canvas>

<style>
    :global(body) {
        margin: 0;
        overflow: hidden;
        background-color: #050510;
    }
</style>
