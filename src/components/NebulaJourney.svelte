<script lang="ts">
    import { fade } from "svelte/transition";
    import { _ } from "../lib/i18n";

    const articleData = {
        title: "Os Pilares da Criação: Berçários Estelares",
        date: "2026-01-26",
        author: "Antigravity",
        description:
            "Onde as estrelas nascem. Uma nuvem colossal de gás e poeira esculpida pela radiação de estrelas recém-nascidas.",
        tags: ["Nebulosa", "Formação Estelar", "Química Cósmica"],
    };
</script>

<div
    class="absolute inset-0 z-10 pointer-events-none overflow-y-auto overflow-x-hidden scroll-smooth"
    id="nebula-journal-container"
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
                <p>{$_("nebula.scroll_hint")}</p>
                <div class="animate-bounce mt-4 text-white opacity-80">↓</div>
            </div>
        </div>

        <!-- TITULO -->
        <header
            class="bg-black/70 backdrop-blur-xl rounded-2xl p-12 border border-white/10 text-center space-y-4 pointer-events-auto shadow-[0_0_50px_rgba(168,85,247,0.2)]"
            in:fade={{ duration: 1000, delay: 200 }}
        >
            <h1
                class="text-4xl md:text-7xl font-black text-transparent bg-clip-text bg-gradient-to-br from-pink-300 via-purple-300 to-indigo-400 leading-tight uppercase tracking-tighter drop-shadow-2xl"
            >
                {$_("nebula.title_main")}
            </h1>
            <h2
                class="text-xl md:text-3xl font-light text-purple-100 uppercase tracking-widest drop-shadow-lg"
            >
                {$_("nebula.title_sub")}
            </h2>
        </header>

        <div class="h-[15vh] pointer-events-none" aria-hidden="true"></div>

        <!-- INTRO -->
        <section
            class="bg-black/80 backdrop-blur-xl rounded-2xl p-8 border border-white/10 shadow-2xl text-center space-y-6 pointer-events-auto"
        >
            <div class="inline-flex gap-2 flex-wrap justify-center mb-2">
                {#each $_("nebula.tags") as tag}
                    <span
                        class="px-3 py-1 rounded-full text-xs font-semibold bg-purple-500/20 text-purple-200 border border-purple-500/30 uppercase tracking-wider"
                    >
                        {tag}
                    </span>
                {/each}
            </div>

            <p
                class="text-xl md:text-2xl text-gray-200 italic max-w-xl mx-auto leading-relaxed"
            >
                "{$_("nebula.description")}"
            </p>
        </section>

        <!-- SEÇÃO 1: NUVENS -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-pink-300 border-b border-white/10 pb-4 mb-6"
            >
                {$_("nebula.section1.title")}
            </h2>
            <div class="space-y-6 text-gray-200 leading-relaxed font-light">
                <p>
                    {$_("nebula.section1.p1")}
                </p>
                <p>
                    {$_("nebula.section1.p2")}
                </p>
            </div>
        </section>

        <!-- SEÇÃO 2: CORES -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-blue-300 border-b border-white/10 pb-4 mb-6"
            >
                {$_("nebula.section2.title")}
            </h2>
            <div class="space-y-6 text-gray-200 leading-relaxed font-light">
                <p>
                    {$_("nebula.section2.p1")}
                </p>

                <ul class="space-y-4">
                    <li class="flex items-start gap-3">
                        <div
                            class="mt-1.5 w-3 h-3 rounded-full bg-pink-500 shadow-[0_0_10px_pink]"
                        ></div>
                        <div>
                            <strong class="text-pink-300"
                                >{$_("nebula.section2.pink_title")}</strong
                            >
                            {$_("nebula.section2.pink_desc")}
                        </div>
                    </li>
                    <li class="flex items-start gap-3">
                        <div
                            class="mt-1.5 w-3 h-3 rounded-full bg-cyan-400 shadow-[0_0_10px_cyan]"
                        ></div>
                        <div>
                            <strong class="text-cyan-300"
                                >{$_("nebula.section2.cyan_title")}</strong
                            >
                            {$_("nebula.section2.cyan_desc")}
                        </div>
                    </li>
                </ul>
            </div>
        </section>

        <!-- SEÇÃO 3: NASCIMENTO -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-indigo-300 border-b border-white/10 pb-4 mb-6"
            >
                {$_("nebula.section3.title")}
            </h2>
            <div class="space-y-6 text-gray-200 leading-relaxed font-light">
                <p>
                    {$_("nebula.section3.p1")}
                </p>
            </div>
        </section>
    </div>
</div>

<style>
    #nebula-journal-container::-webkit-scrollbar {
        width: 6px;
    }
    #nebula-journal-container::-webkit-scrollbar-track {
        background: rgba(0, 0, 0, 0.1);
    }
    #nebula-journal-container::-webkit-scrollbar-thumb {
        background: rgba(200, 100, 255, 0.2);
        border-radius: 10px;
    }
    #nebula-journal-container::-webkit-scrollbar-thumb:hover {
        background: rgba(200, 100, 255, 0.4);
    }
</style>
