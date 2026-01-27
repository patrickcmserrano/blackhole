<script lang="ts">
    import { fade } from "svelte/transition";
    import { _ } from "../lib/i18n";

    const articleData = {
        title: "Faróis do Universo: Estrelas de Nêutrons",
        date: "2026-01-26",
        author: "Patrick Serrano",
        description:
            "Uma viagem ao objeto mais denso do cosmos, onde a matéria é esmagada ao limite e campos magnéticos desafiam a imaginação.",
        tags: ["Astrofísica", "Pulsar", "Three.js", "Magnetismo"],
    };
</script>

<div
    class="absolute inset-0 z-10 pointer-events-none overflow-y-auto overflow-x-hidden scroll-smooth"
    id="journal-container"
>
    <div
        class="w-full max-w-2xl mx-auto px-6 py-12 md:py-24 space-y-8 pointer-events-none"
    >
        <!-- ESPAÇO INICIAL -->
        <div
            class="h-[85vh] flex flex-col justify-end items-center pointer-events-none"
            aria-hidden="true"
        >
            <div
                class="text-center text-white text-sm pb-12 animate-pulse pointer-events-auto drop-shadow-[0_0_8px_rgba(0,0,0,0.8)]"
            >
                <p>{$_("neutron.scroll_hint")}</p>
                <div class="animate-bounce mt-4 text-blue-400 opacity-80">
                    ↓
                </div>
            </div>
        </div>

        <!-- TITULO PRINCIPAL -->
        <header
            class="bg-black/70 backdrop-blur-xl rounded-2xl p-12 border border-blue-500/20 text-center space-y-4 pointer-events-auto shadow-[0_0_50px_rgba(0,100,255,0.2)]"
            in:fade={{ duration: 1000, delay: 200 }}
        >
            <h1
                class="text-4xl md:text-8xl font-black text-transparent bg-clip-text bg-gradient-to-br from-blue-100 via-cyan-200 to-blue-500 leading-tight uppercase tracking-tighter drop-shadow-2xl"
            >
                {$_("neutron.title_main")}
            </h1>
            <h2
                class="text-xl md:text-3xl font-light text-cyan-200 uppercase tracking-widest drop-shadow-lg"
            >
                {$_("neutron.title_sub")}
            </h2>
        </header>

        <div class="h-[15vh] pointer-events-none" aria-hidden="true"></div>

        <!-- INTRODUÇÃO -->
        <section
            class="bg-black/80 backdrop-blur-xl rounded-2xl p-8 border border-blue-500/20 shadow-2xl text-center space-y-6 pointer-events-auto"
        >
            <div class="inline-flex gap-2 flex-wrap justify-center mb-2">
                {#each $_("neutron.tags") as tag}
                    <span
                        class="px-3 py-1 rounded-full text-xs font-semibold bg-cyan-500/20 text-cyan-200 border border-cyan-500/30 uppercase tracking-wider"
                    >
                        {tag}
                    </span>
                {/each}
            </div>

            <p
                class="text-xl md:text-2xl text-gray-200 italic max-w-xl mx-auto leading-relaxed"
            >
                "{$_("neutron.description")}"
            </p>

            <div
                class="flex items-center justify-center gap-4 text-sm text-gray-300 font-mono border-t border-white/10 pt-6"
            >
                <span>{$_("common.date")}</span>
                <span>•</span>
                <span>{$_("common.author")}</span>
            </div>
        </section>

        <!-- SECTION 1: O QUE É -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-blue-500/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-cyan-300 border-b border-blue-500/20 pb-4 mb-6"
            >
                {$_("neutron.section1.title")}
            </h2>

            <div class="space-y-6 text-gray-200 leading-relaxed font-light">
                <p>
                    {$_("neutron.section1.p1")}
                </p>

                <div
                    class="bg-blue-900/30 border-l-4 border-cyan-500 p-4 my-6 rounded-r-lg"
                >
                    <p class="text-sm">
                        <strong class="text-cyan-300"
                            >{$_("neutron.section1.density_title")}</strong
                        >
                        {$_("neutron.section1.density_desc")}
                    </p>
                </div>

                <h3 class="text-xl font-semibold text-white mt-8 mb-4">
                    {$_("neutron.section1.crust_title")}
                </h3>
                <p>
                    {$_("neutron.section1.crust_p")}
                </p>
            </div>
        </section>

        <!-- SECTION 2: PULSARES -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-blue-500/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-cyan-300 border-b border-blue-500/20 pb-4 mb-6"
            >
                {$_("neutron.section2.title")}
            </h2>
            <p class="text-gray-300">
                {$_("neutron.section2.p1")}
            </p>
            <p class="text-gray-300">
                {$_("neutron.section2.p2")}
            </p>
        </section>

        <!-- SECTION 3: MAGNETISMO -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-blue-500/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-cyan-300 border-b border-blue-500/20 pb-4 mb-6"
            >
                {$_("neutron.section3.title")}
            </h2>

            <!-- Magnetar Info -->
            <div class="bg-gray-900/50 rounded-xl p-6 border border-white/5">
                <h3 class="text-xl font-semibold text-white mb-4">
                    {$_("neutron.section3.magnetar_title")}
                </h3>
                <p class="text-gray-400 text-sm mb-6">
                    {$_("neutron.section3.magnetar_desc")}
                </p>

                <div
                    class="grid grid-cols-1 md:grid-cols-2 gap-4 text-xs md:text-sm text-gray-400 font-mono bg-black/20 p-4 rounded-lg"
                >
                    <div>
                        <span class="text-cyan-300 font-bold"
                            >{$_("neutron.section3.earth")}</span
                        > ~0.5 Gauss
                    </div>
                    <div>
                        <span class="text-cyan-300 font-bold"
                            >{$_("neutron.section3.fridge_magnet")}</span
                        > ~100 Gauss
                    </div>
                    <div>
                        <span class="text-cyan-300 font-bold"
                            >{$_("neutron.section3.mri")}</span
                        > ~10,000 Gauss
                    </div>
                    <div>
                        <span class="text-cyan-300 font-bold"
                            >{$_("neutron.section3.magnetar")}</span
                        > ~1,000,000,000,000,000 Gauss
                    </div>
                </div>

                <p class="text-xs text-gray-500 mt-4 italic">
                    {$_("neutron.section3.magnetar_warning")}
                </p>
            </div>
        </section>
    </div>
</div>

<style>
    /* Custom scrollbar copied from original */
    #journal-container::-webkit-scrollbar {
        width: 6px;
    }
    #journal-container::-webkit-scrollbar-track {
        background: rgba(0, 0, 0, 0.1);
    }
    #journal-container::-webkit-scrollbar-thumb {
        background: rgba(100, 200, 255, 0.2);
        border-radius: 10px;
    }
    #journal-container::-webkit-scrollbar-thumb:hover {
        background: rgba(100, 200, 255, 0.3);
    }
</style>
