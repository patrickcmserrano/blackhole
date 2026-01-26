<script lang="ts">
    import { fade } from "svelte/transition";

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
                class="text-center text-blue-200 text-sm pb-12 animate-pulse pointer-events-auto"
            >
                <p>Observe o farol cósmico</p>
                <div class="animate-bounce mt-4 text-blue-400 opacity-50">
                    ↓
                </div>
            </div>
        </div>

        <!-- TITULO PRINCIPAL -->
        <header
            class="bg-blue-900/20 backdrop-blur-sm rounded-2xl p-12 border border-blue-500/10 text-center space-y-4 pointer-events-auto"
            in:fade={{ duration: 1000, delay: 200 }}
        >
            <h1
                class="text-4xl md:text-8xl font-black text-transparent bg-clip-text bg-gradient-to-br from-blue-100 via-cyan-200 to-blue-500 leading-tight uppercase tracking-tighter"
            >
                Estrelas de Nêutrons
            </h1>
            <h2
                class="text-xl md:text-3xl font-light text-blue-200/60 uppercase tracking-widest"
            >
                A Rainha da Densidade
            </h2>
        </header>

        <div class="h-[15vh] pointer-events-none" aria-hidden="true"></div>

        <!-- INTRODUÇÃO -->
        <section
            class="bg-black/60 backdrop-blur-md rounded-2xl p-8 border border-blue-500/10 shadow-2xl text-center space-y-6 pointer-events-auto"
        >
            <div class="inline-flex gap-2 flex-wrap justify-center mb-2">
                {#each articleData.tags as tag}
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
                "{articleData.description}"
            </p>

            <div
                class="flex items-center justify-center gap-4 text-sm text-gray-500 font-mono border-t border-white/5 pt-6"
            >
                <span>{articleData.date}</span>
                <span>•</span>
                <span>{articleData.author}</span>
            </div>
        </section>

        <!-- SECTION 1: O QUE É -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-blue-500/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-cyan-300 border-b border-blue-500/20 pb-4 mb-6"
            >
                1. O Cadáver Estelar
            </h2>

            <div class="space-y-6 text-gray-200 leading-relaxed font-light">
                <p>
                    Quando uma estrela gigante morre em uma supernova, mas não é
                    massiva o suficiente para virar um buraco negro, ela vira
                    isso: uma bola de nêutrons puros.
                </p>

                <div
                    class="bg-blue-900/30 border-l-4 border-cyan-500 p-4 my-6 rounded-r-lg"
                >
                    <p class="text-sm">
                        <strong class="text-cyan-300"
                            >Densidade Inconcebível:</strong
                        > Imagine espremer a massa de 1,5 Sóis dentro de uma esfera
                        do tamanho da ilha de Manhattan (aprox. 20km). Uma colher
                        de chá dessa matéria pesaria tanto quanto o Monte Everest.
                    </p>
                </div>

                <h3 class="text-xl font-semibold text-white mt-8 mb-4">
                    A Crosta de Ferro
                </h3>
                <p>
                    Ao contrário de estrelas normais gasosas, elas possuem uma
                    crosta sólida, 10 bilhões de vezes mais dura que o aço.
                    "Montanhas" nessa superfície teriam apenas alguns milímetros
                    de altura devido à gravidade esmagadora.
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
                2. O Farol Cósmico (Pulsares)
            </h2>
            <p class="text-gray-300">
                Muitas estrelas de nêutrons giram insanamente rápido — centenas
                de vezes por segundo. Elas emitem feixes de radiação pelos polos
                magnéticos.
            </p>
            <p class="text-gray-300">
                Como o eixo magnético nem sempre alinha com o eixo de rotação,
                esses feixes varrem o céu. Se a Terra estiver no caminho, vemos
                um "pulso" de luz regular, como um farol marítimo. Daí o nome: <strong
                    >Pulsar</strong
                >.
            </p>
        </section>

        <!-- SECTION 3: MAGNETISMO -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-blue-500/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-cyan-300 border-b border-blue-500/20 pb-4 mb-6"
            >
                3. Magnetismo Extremo
            </h2>

            <!-- Magnetar Info -->
            <div class="bg-gray-900/50 rounded-xl p-6 border border-white/5">
                <h3 class="text-xl font-semibold text-white mb-4">Magnetars</h3>
                <p class="text-gray-400 text-sm mb-6">
                    Algumas estrelas de nêutrons, chamadas Magnetars, possuem os
                    campos magnéticos mais fortes do universo.
                </p>

                <div
                    class="grid grid-cols-1 md:grid-cols-2 gap-4 text-xs md:text-sm text-gray-400 font-mono bg-black/20 p-4 rounded-lg"
                >
                    <div>
                        <span class="text-cyan-300 font-bold">Terra:</span> ~0.5
                        Gauss
                    </div>
                    <div>
                        <span class="text-cyan-300 font-bold"
                            >Ímã de Geladeira:</span
                        > ~100 Gauss
                    </div>
                    <div>
                        <span class="text-cyan-300 font-bold"
                            >Ressonância Magnética:</span
                        > ~10,000 Gauss
                    </div>
                    <div>
                        <span class="text-cyan-300 font-bold">Magnetar:</span> ~1,000,000,000,000,000
                        Gauss
                    </div>
                </div>

                <p class="text-xs text-gray-500 mt-4 italic">
                    Esse campo é tão forte que, a 1000km de distância, ele
                    distorceria os átomos do seu corpo, transformando sua
                    química em algo impossível de sustentar a vida.
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
