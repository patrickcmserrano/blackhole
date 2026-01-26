<script lang="ts">
    import { fade } from "svelte/transition";

    const articleData = {
        title: "O Senhor dos Anéis: Saturno Revelado",
        date: "2026-01-26",
        author: "Antigravity",
        description:
            "Uma viagem visual ao gigante gasoso, seus anéis de gelo e as luas que guardam segredos de vida.",
        tags: ["Sistema Solar", "Cassini", "Astronomia", "Three.js"],
    };
</script>

<div
    class="absolute inset-0 z-10 pointer-events-none overflow-y-auto overflow-x-hidden scroll-smooth"
    id="saturn-journal-container"
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
                class="text-center text-gray-400 text-sm pb-12 animate-pulse pointer-events-auto"
            >
                <p>Explore os anéis</p>
                <div class="animate-bounce mt-4 text-white opacity-50">↓</div>
            </div>
        </div>

        <!-- TITULO -->
        <header
            class="bg-black/20 backdrop-blur-sm rounded-2xl p-12 border border-white/5 text-center space-y-4 pointer-events-auto"
            in:fade={{ duration: 1000, delay: 200 }}
        >
            <h1
                class="text-4xl md:text-7xl font-black text-transparent bg-clip-text bg-gradient-to-br from-amber-100 via-orange-200 to-amber-500 leading-tight uppercase tracking-tighter"
            >
                O Senhor dos Anéis
            </h1>
            <h2
                class="text-xl md:text-3xl font-light text-amber-200/60 uppercase tracking-widest"
            >
                Saturn's Grandeur
            </h2>
        </header>

        <div class="h-[15vh] pointer-events-none" aria-hidden="true"></div>

        <!-- INTRO -->
        <section
            class="bg-black/60 backdrop-blur-md rounded-2xl p-8 border border-white/10 shadow-2xl text-center space-y-6 pointer-events-auto"
        >
            <div class="inline-flex gap-2 flex-wrap justify-center mb-2">
                {#each articleData.tags as tag}
                    <span
                        class="px-3 py-1 rounded-full text-xs font-semibold bg-amber-500/20 text-amber-200 border border-amber-500/30 uppercase tracking-wider"
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
        </section>

        <!-- SEÇÃO 1: OS ANÉIS -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-amber-300 border-b border-white/10 pb-4 mb-6"
            >
                1. Não é um Disco Sólido
            </h2>
            <div class="space-y-6 text-gray-200 leading-relaxed font-light">
                <p>
                    Embora pareçam sólidos vistos da Terra, os anéis de Saturno
                    são, na verdade, compostos por
                    <strong class="text-white"
                        >bilhões de pedaços de gelo e rocha</strong
                    >.
                </p>
                <p>
                    O tamanho dessas partículas varia de grãos de poeira a
                    montanhas inteiras. A visualização que você vê usa milhares
                    de pequenas rochas simuladas individualmente para recriar
                    essa dispersão.
                </p>

                <div
                    class="bg-amber-900/30 border-l-4 border-amber-500 p-4 my-6 rounded-r-lg"
                >
                    <p class="text-sm">
                        <strong class="text-amber-300"
                            >Fato Surpreendente:</strong
                        >
                        Apesar de terem milhares de quilômetros de largura, os
                        anéis são incrivelmente finos — em média, têm apenas
                        cerca de
                        <strong class="text-white"
                            >10 metros de espessura</strong
                        >.
                    </p>
                </div>
            </div>
        </section>

        <!-- SEÇÃO 2: AS LUAS -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-amber-300 border-b border-white/10 pb-4 mb-6"
            >
                2. As Luas Pastoras e a Vida
            </h2>
            <div class="space-y-6 text-gray-200 leading-relaxed font-light">
                <p>
                    Saturno não reina sozinho. Ele é acompanhado por uma corte
                    de dezenas de luas. Algumas, chamadas de
                    <strong class="text-white">Luas Pastoras</strong>, orbitam
                    dentro ou perto dos anéis, usando sua gravidade para manter
                    as partículas de gelo em ordem, criando as falhas visíveis
                    entre os anéis.
                </p>

                <h3 class="text-xl font-semibold text-white mt-8 mb-4">
                    Encélado: Onde a Vida Pode Existir
                </h3>
                <p>
                    Uma das luas mais fascinantes é <strong
                        class="text-blue-200">Encélado</strong
                    >. Coberta por uma camada de gelo branco brilhante, ela
                    esconde um oceano global de água líquida abaixo da
                    superfície. Gêiseres gigantes cospem água no espaço,
                    sugerindo que este pequeno mundo pode ter todos os
                    ingredientes necessários para a vida.
                </p>
            </div>
        </section>

        <!-- SEÇÃO 3: CASSINI -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-amber-300 border-b border-white/10 pb-4 mb-6"
            >
                3. O Legado da Cassini
            </h2>
            <div class="space-y-6 text-gray-200 leading-relaxed font-light">
                <p>
                    Muito do que sabemos hoje vem da missão <strong
                        class="text-white">Cassini-Huygens</strong
                    > (1997-2017). Durante 13 anos, a sonda orbitou Saturno, enviando
                    imagens deslumbrantes e dados revolucionários.
                </p>
                <p>
                    Em seu "Grand Finale", a Cassini mergulhou corajosamente no
                    espaço estreito entre o planeta e seus anéis, antes de se
                    desintegrar na atmosfera de Saturno para proteger as luas de
                    contaminação terrestre.
                </p>
            </div>
        </section>
    </div>
</div>

<style>
    #saturn-journal-container::-webkit-scrollbar {
        width: 6px;
    }
    #saturn-journal-container::-webkit-scrollbar-track {
        background: rgba(0, 0, 0, 0.1);
    }
    #saturn-journal-container::-webkit-scrollbar-thumb {
        background: rgba(255, 200, 100, 0.2);
        border-radius: 10px;
    }
    #saturn-journal-container::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 200, 100, 0.4);
    }
</style>
