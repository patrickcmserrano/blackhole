<script lang="ts">
    import { fade, fly } from "svelte/transition";
    import { _ } from "../lib/i18n";

    // Data from the user request
    const articleData = {
        title: "No Limite da Realidade: Uma Jornada Interativa aos Buracos Negros",
        date: "2026-01-24",
        author: "Patrick Serrano",
        description:
            "Uma exploração visual e interativa sobre a física, história e mistério dos buracos negros, potencializada por Three.js.",
        tags: ["Astrofísica", "Educação", "Three.js", "Interativo"],
    };
</script>

<div
    class="absolute inset-0 z-10 pointer-events-none overflow-y-auto overflow-x-hidden scroll-smooth"
    id="journal-container"
>
    <div
        class="w-full max-w-2xl mx-auto px-6 py-12 md:py-24 space-y-8 pointer-events-none"
    >
        <!-- ESPAÇO INICIAL PARA OBSERVAR O BURACO NEGRO -->
        <div
            class="h-[85vh] flex flex-col justify-end items-center pointer-events-none"
            aria-hidden="true"
        >
            <div
                class="text-center text-white text-sm pb-12 animate-pulse pointer-events-auto drop-shadow-[0_0_8px_rgba(0,0,0,0.8)]"
            >
                <p>{$_("common.scroll_hint")}</p>
                <div class="animate-bounce mt-4 text-white opacity-80">↓</div>
            </div>
        </div>

        <!-- TITULO PRINCIPAL -->
        <header
            class="bg-black/70 backdrop-blur-xl rounded-2xl p-12 border border-white/10 text-center space-y-4 pointer-events-auto shadow-[0_0_50px_rgba(0,0,0,0.5)]"
            in:fade={{ duration: 1000, delay: 200 }}
        >
            <h1
                class="text-4xl md:text-8xl font-black text-transparent bg-clip-text bg-gradient-to-br from-white via-indigo-100 to-indigo-400 leading-tight uppercase tracking-tighter drop-shadow-2xl"
            >
                {$_("blackhole.title_main")}
            </h1>
            <h2
                class="text-xl md:text-3xl font-light text-indigo-100 uppercase tracking-widest drop-shadow-lg"
            >
                {$_("blackhole.title_sub")}
            </h2>
        </header>

        <!-- ESPAÇO ENTRE TITULO E INTRODUÇÃO -->
        <div class="h-[15vh] pointer-events-none" aria-hidden="true"></div>

        <!-- INTRODUÇÃO E METADADOS -->
        <section
            class="bg-black/80 backdrop-blur-xl rounded-2xl p-8 border border-white/10 shadow-2xl text-center space-y-6 pointer-events-auto"
        >
            <div class="inline-flex gap-2 flex-wrap justify-center mb-2">
                {#each $_("blackhole.tags") as tag}
                    <span
                        class="px-3 py-1 rounded-full text-xs font-semibold bg-indigo-500/20 text-indigo-200 border border-indigo-500/30 uppercase tracking-wider"
                    >
                        {tag}
                    </span>
                {/each}
            </div>

            <p
                class="text-xl md:text-2xl text-gray-200 italic max-w-xl mx-auto leading-relaxed"
            >
                "{$_("blackhole.description")}"
            </p>

            <div
                class="flex items-center justify-center gap-4 text-sm text-gray-300 font-mono border-t border-white/10 pt-6"
            >
                <span>{$_("common.date")}</span>
                <span>•</span>
                <span>{$_("common.author")}</span>
            </div>
        </section>

        <!-- SECTION 1: WHAT IS A BLACK HOLE -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl transition-transform hover:scale-[1.01] duration-500 pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-indigo-300 border-b border-white/10 pb-4 mb-6"
            >
                {$_("blackhole.section1.title")}
            </h2>

            <div class="space-y-6 text-gray-200 leading-relaxed font-light">
                <h3 class="text-xl font-semibold text-white">
                    {$_("blackhole.section1.subtitle")}
                </h3>
                <p>
                    {$_("blackhole.section1.p1")}
                </p>
                <p>
                    {$_("blackhole.section1.p2")}
                </p>

                <div
                    class="bg-indigo-900/30 border-l-4 border-indigo-500 p-4 my-6 rounded-r-lg"
                >
                    <p class="text-sm">
                        <strong class="text-indigo-300"
                            >{$_("blackhole.section1.analogy").split(
                                ":",
                            )[0]}:</strong
                        >
                        {$_("blackhole.section1.analogy").split(":")[1]}
                    </p>
                </div>

                <h3 class="text-xl font-semibold text-white mt-8 mb-4">
                    {$_("blackhole.section1.anatomy_title")}
                </h3>
                <ul class="space-y-4">
                    <li class="flex items-start gap-3">
                        <div
                            class="mt-1.5 w-2 h-2 rounded-full bg-white shadow-[0_0_10px_white] shrink-0"
                        ></div>
                        <div>
                            <strong class="text-indigo-200"
                                >{$_(
                                    "blackhole.section1.event_horizon",
                                )}</strong
                            >
                            {$_("blackhole.section1.event_horizon_desc")}
                        </div>
                    </li>
                    <li class="flex items-start gap-3">
                        <div
                            class="mt-1.5 w-2 h-2 rounded-full bg-purple-500 shadow-[0_0_10px_purple] shrink-0"
                        ></div>
                        <div>
                            <strong class="text-purple-300"
                                >{$_("blackhole.section1.singularity")}</strong
                            >
                            {$_("blackhole.section1.singularity_desc")}
                        </div>
                    </li>
                    <li class="flex items-start gap-3">
                        <div
                            class="mt-1.5 w-2 h-2 rounded-full bg-orange-500 shadow-[0_0_10px_orange] shrink-0"
                        ></div>
                        <div>
                            <strong class="text-orange-300"
                                >{$_(
                                    "blackhole.section1.accretion_disk",
                                )}</strong
                            >
                            {$_("blackhole.section1.accretion_disk_desc")}
                        </div>
                    </li>
                </ul>
            </div>
        </section>

        <!-- SECTION 2: GIANTS OF SCIENCE -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-indigo-300 border-b border-white/10 pb-4 mb-6"
            >
                {$_("blackhole.section2.title")}
            </h2>
            <p class="text-gray-300 mb-8">
                {$_("blackhole.section2.p1")}
            </p>

            <div
                class="relative border-l border-indigo-500/30 ml-3 md:ml-6 space-y-12 py-4"
            >
                <!-- 1783 -->
                <div class="relative pl-8 md:pl-12">
                    <span
                        class="absolute -left-1.5 top-1.5 w-3 h-3 rounded-full bg-indigo-500 ring-4 ring-black"
                    ></span>
                    <span class="text-xs font-mono text-indigo-400 mb-1 block"
                        >1783</span
                    >
                    <h3 class="text-lg font-bold text-white mb-2">
                        {$_("blackhole.section2.year_1783_title")}
                    </h3>
                    <p class="text-gray-300 text-sm leading-relaxed">
                        {$_("blackhole.section2.year_1783_desc")}
                    </p>
                </div>

                <!-- 1915 -->
                <div class="relative pl-8 md:pl-12">
                    <span
                        class="absolute -left-1.5 top-1.5 w-3 h-3 rounded-full bg-indigo-500 ring-4 ring-black"
                    ></span>
                    <span class="text-xs font-mono text-indigo-400 mb-1 block"
                        >1915</span
                    >
                    <h3 class="text-lg font-bold text-white mb-2">
                        {$_("blackhole.section2.year_1915_title")}
                    </h3>
                    <p class="text-gray-300 text-sm leading-relaxed">
                        {$_("blackhole.section2.year_1915_desc")}
                        <br /><br />
                        <span class="italic text-white/80"
                            >{$_("blackhole.section2.einstein_quote")}</span
                        >
                    </p>
                </div>

                <!-- 1916 -->
                <div class="relative pl-8 md:pl-12">
                    <span
                        class="absolute -left-1.5 top-1.5 w-3 h-3 rounded-full bg-indigo-500 ring-4 ring-black"
                    ></span>
                    <span class="text-xs font-mono text-indigo-400 mb-1 block"
                        >1916</span
                    >
                    <h3 class="text-lg font-bold text-white mb-2">
                        {$_("blackhole.section2.year_1916_title")}
                    </h3>
                    <p class="text-gray-300 text-sm leading-relaxed">
                        {$_("blackhole.section2.year_1916_desc")}
                    </p>
                </div>

                <!-- 60s & 70s -->
                <div class="relative pl-8 md:pl-12">
                    <span
                        class="absolute -left-1.5 top-1.5 w-3 h-3 rounded-full bg-indigo-500 ring-4 ring-black"
                    ></span>
                    <span class="text-xs font-mono text-indigo-400 mb-1 block"
                        >Anos 60 e 70</span
                    >
                    <h3 class="text-lg font-bold text-white mb-2">
                        {$_("blackhole.section2.era_golden_title")}
                    </h3>
                    <ul class="text-gray-300 text-sm leading-relaxed space-y-2">
                        <li>
                            <strong class="text-indigo-200"
                                >{$_("blackhole.section2.wheeler_name")}</strong
                            >
                            {$_("blackhole.section2.wheeler_desc")}
                        </li>
                        <li>
                            <strong class="text-indigo-200"
                                >{$_("blackhole.section2.penrose_name")}</strong
                            >
                            {$_("blackhole.section2.penrose_desc")}
                        </li>
                        <li>
                            <strong class="text-indigo-200"
                                >{$_("blackhole.section2.hawking_name")}</strong
                            >
                            {$_("blackhole.section2.hawking_desc")}
                        </li>
                    </ul>
                </div>

                <!-- 2019 -->
                <div class="relative pl-8 md:pl-12">
                    <span
                        class="absolute -left-1.5 top-1.5 w-3 h-3 rounded-full bg-indigo-500 ring-4 ring-black"
                    ></span>
                    <span class="text-xs font-mono text-indigo-400 mb-1 block"
                        >2019</span
                    >
                    <h3 class="text-lg font-bold text-white mb-2">
                        {$_("blackhole.section2.year_2019_title")}
                    </h3>
                    <p class="text-gray-300 text-sm leading-relaxed">
                        {$_("blackhole.section2.year_2019_desc")}
                    </p>
                </div>
            </div>
        </section>

        <!-- SECTION 3: MATH -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-indigo-300 border-b border-white/10 pb-4 mb-6"
            >
                {$_("blackhole.section3.title")}
            </h2>
            <p class="text-gray-300">
                {$_("blackhole.section3.p1")}
            </p>

            <!-- Schwarzschild Radius -->
            <div class="bg-gray-900/50 rounded-xl p-6 border border-white/5">
                <h3 class="text-xl font-semibold text-white mb-4">
                    {$_("blackhole.section3.schwarzschild_title")}
                </h3>
                <p class="text-gray-400 text-sm mb-6">
                    {$_("blackhole.section3.schwarzschild_desc")}
                </p>

                <div class="flex justify-center my-8 overflow-x-auto">
                    <div
                        class="font-serif text-3xl md:text-4xl text-white italic tracking-wider"
                    >
                        R<sub>s</sub> =
                        <span class="align-middle inline-block text-center"
                            ><span class="block border-b border-white pb-1 mb-1"
                                >2GM</span
                            ><span class="block">c<sup>2</sup></span></span
                        >
                    </div>
                </div>

                <div
                    class="grid grid-cols-2 gap-4 text-xs md:text-sm text-gray-400 font-mono bg-black/20 p-4 rounded-lg"
                >
                    <div>
                        <span class="text-indigo-300 font-bold">Rs</span> : {$_(
                            "blackhole.section3.rs",
                        )}
                    </div>
                    <div>
                        <span class="text-indigo-300 font-bold">M</span> : {$_(
                            "blackhole.section3.m",
                        )}
                    </div>
                    <div>
                        <span class="text-indigo-300 font-bold">G</span> : {$_(
                            "blackhole.section3.g",
                        )}
                    </div>
                    <div>
                        <span class="text-indigo-300 font-bold">c</span> : {$_(
                            "blackhole.section3.c",
                        )}
                    </div>
                </div>
            </div>

            <!-- Einstein Field Equations -->
            <div
                class="bg-gray-900/50 rounded-xl p-6 border border-white/5 mt-8"
            >
                <h3 class="text-xl font-semibold text-white mb-4">
                    {$_("blackhole.section3.einstein_eq_title")}
                </h3>
                <p class="text-gray-400 text-sm mb-6">
                    {$_("blackhole.section3.einstein_eq_desc")}
                </p>

                <div class="flex justify-center my-8 overflow-x-auto">
                    <div
                        class="font-serif text-3xl md:text-4xl text-white italic tracking-wider"
                    >
                        G<sub>&mu;&nu;</sub> =
                        <span class="align-middle inline-block text-center mx-2"
                            ><span class="block border-b border-white pb-1 mb-1"
                                >8&pi;G</span
                            ><span class="block">c<sup>4</sup></span></span
                        >
                        T<sub>&mu;&nu;</sub>
                    </div>
                </div>

                <div class="space-y-4 text-sm text-gray-300">
                    <p>
                        <strong class="text-white"
                            >{$_("blackhole.section3.left_side")}</strong
                        >
                        {$_("blackhole.section3.left_side_desc")}
                    </p>
                    <p>
                        <strong class="text-white"
                            >{$_("blackhole.section3.right_side")}</strong
                        >
                        {$_("blackhole.section3.right_side_desc")}
                    </p>
                    <p class="italic text-indigo-300 text-center mt-4">
                        {$_("blackhole.section3.einstein_summary")}
                    </p>
                </div>
            </div>
        </section>

        <!-- SECTION 4: WHY IT MATTERS -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-indigo-300 border-b border-white/10 pb-4 mb-6"
            >
                {$_("blackhole.section4.title")}
            </h2>

            <div class="grid md:grid-cols-2 gap-6">
                <div
                    class="bg-white/5 p-6 rounded-xl hover:bg-white/10 transition-colors"
                >
                    <h3 class="text-lg font-bold text-white mb-2">
                        {$_("blackhole.section4.item1_title")}
                    </h3>
                    <p class="text-sm text-gray-300">
                        {$_("blackhole.section4.item1_desc")}
                    </p>
                </div>

                <div
                    class="bg-white/5 p-6 rounded-xl hover:bg-white/10 transition-colors"
                >
                    <h3 class="text-lg font-bold text-white mb-2">
                        {$_("blackhole.section4.item2_title")}
                    </h3>
                    <p class="text-sm text-gray-300">
                        {$_("blackhole.section4.item2_desc")}
                    </p>
                </div>

                <div
                    class="bg-white/5 p-6 rounded-xl hover:bg-white/10 transition-colors"
                >
                    <h3 class="text-lg font-bold text-white mb-2">
                        {$_("blackhole.section4.item3_title")}
                    </h3>
                    <p class="text-sm text-gray-300">
                        {$_("blackhole.section4.item3_desc")}
                    </p>
                </div>

                <div
                    class="bg-white/5 p-6 rounded-xl hover:bg-white/10 transition-colors"
                >
                    <h3 class="text-lg font-bold text-white mb-2">
                        {$_("blackhole.section4.item4_title")}
                    </h3>
                    <p class="text-sm text-gray-300">
                        {$_("blackhole.section4.item4_desc")}
                    </p>
                </div>
            </div>
        </section>

        <!-- SECTION 5: BEHIND THE CODE -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl pointer-events-auto mb-24"
        >
            <h2
                class="text-3xl font-bold text-indigo-300 border-b border-white/10 pb-4 mb-6"
            >
                {$_("blackhole.section5.title")}
            </h2>
            <p class="text-gray-300 mb-8">
                {$_("blackhole.section5.intro")}
            </p>

            <div class="space-y-6">
                <!-- Shaders -->
                <div class="flex flex-col md:flex-row gap-4 items-start">
                    <div class="bg-indigo-500/20 p-3 rounded-lg shrink-0">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="w-6 h-6 text-indigo-300"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                        >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"
                            />
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-lg font-bold text-white mb-1">
                            {$_("blackhole.section5.item1_title")}
                        </h3>
                        <p class="text-sm text-gray-300">
                            {$_("blackhole.section5.item1_desc")}
                        </p>
                    </div>
                </div>

                <!-- Noise -->
                <div class="flex flex-col md:flex-row gap-4 items-start">
                    <div class="bg-indigo-500/20 p-3 rounded-lg shrink-0">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="w-6 h-6 text-indigo-300"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                        >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M19.428 15.428a2 2 0 00-1.022-.547l-2.384-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"
                            />
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-lg font-bold text-white mb-1">
                            {$_("blackhole.section5.item2_title")}
                        </h3>
                        <p class="text-sm text-gray-300">
                            {$_("blackhole.section5.item2_desc")}
                        </p>
                    </div>
                </div>

                <!-- Bloom -->
                <div class="flex flex-col md:flex-row gap-4 items-start">
                    <div class="bg-indigo-500/20 p-3 rounded-lg shrink-0">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="w-6 h-6 text-indigo-300"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                        >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M13 10V3L4 14h7v7l9-11h-7z"
                            />
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-lg font-bold text-white mb-1">
                            {$_("blackhole.section5.item3_title")}
                        </h3>
                        <p class="text-sm text-gray-300">
                            {$_("blackhole.section5.item3_desc")}
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<style>
    /* Custom scrollbar for webkit */
    #journal-container::-webkit-scrollbar {
        width: 6px;
    }
    #journal-container::-webkit-scrollbar-track {
        background: rgba(0, 0, 0, 0.1);
    }
    #journal-container::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 10px;
    }
    #journal-container::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.3);
    }
</style>
