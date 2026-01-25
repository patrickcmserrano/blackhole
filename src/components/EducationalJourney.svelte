<script lang="ts">
    import { fade, fly } from "svelte/transition";

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
        class="w-full max-w-2xl mx-auto px-6 py-24 md:py-32 space-y-32 pointer-events-none"
    >
        <!-- ESPAÇO INICIAL PARA OBSERVAR O BURACO NEGRO -->
        <div
            class="h-[85vh] flex flex-col justify-end items-center pointer-events-none"
            aria-hidden="true"
        >
            <div
                class="text-center text-gray-500 text-sm pb-12 animate-pulse pointer-events-auto"
            >
                <p>Explore o universo abaixo</p>
                <div class="animate-bounce mt-4 text-white opacity-50">↓</div>
            </div>
        </div>

        <!-- TITULO PRINCIPAL -->
        <header
            class="bg-black/20 backdrop-blur-sm rounded-2xl p-12 border border-white/5 text-center space-y-4 pointer-events-auto"
            in:fade={{ duration: 1000, delay: 200 }}
        >
            <h1
                class="text-4xl md:text-8xl font-black text-transparent bg-clip-text bg-gradient-to-br from-white via-indigo-100 to-indigo-400 leading-tight uppercase tracking-tighter"
            >
                No Limite da Realidade
            </h1>
            <h2
                class="text-xl md:text-3xl font-light text-indigo-200/60 uppercase tracking-widest"
            >
                Uma Jornada aos Buracos Negros
            </h2>
        </header>

        <!-- ESPAÇO ENTRE TITULO E INTRODUÇÃO -->
        <div class="h-[60vh] pointer-events-none" aria-hidden="true"></div>

        <!-- INTRODUÇÃO E METADADOS -->
        <section
            class="bg-black/60 backdrop-blur-md rounded-2xl p-8 border border-white/10 shadow-2xl text-center space-y-6 pointer-events-auto"
        >
            <div class="inline-flex gap-2 flex-wrap justify-center mb-2">
                {#each articleData.tags as tag}
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

        <!-- ESPAÇO PARA OBSERVAR O BURACO NEGRO -->
        <div class="h-[80vh] pointer-events-none" aria-hidden="true"></div>

        <!-- SECTION 1: WHAT IS A BLACK HOLE -->
        <section
            class="space-y-8 p-8 bg-black/60 backdrop-blur-lg rounded-2xl border border-white/10 shadow-2xl transition-transform hover:scale-[1.01] duration-500 pointer-events-auto"
        >
            <h2
                class="text-3xl font-bold text-indigo-300 border-b border-white/10 pb-4 mb-6"
            >
                1. O Que é um Buraco Negro?
            </h2>

            <div class="space-y-6 text-gray-200 leading-relaxed font-light">
                <h3 class="text-xl font-semibold text-white">
                    O Derradeiro Ralo Cósmico
                </h3>
                <p>
                    Imagine um lugar onde a gravidade é tão intensa que nada,
                    absolutamente nada, consegue escapar. Nem foguetes, nem
                    partículas, nem mesmo a luz — a coisa mais rápida do
                    universo. Esse lugar é um buraco negro.
                </p>
                <p>
                    Eles não são "buracos" no sentido tradicional, mas sim
                    quantidades imensas de matéria espremida em um espaço
                    incrivelmente pequeno.
                </p>

                <div
                    class="bg-indigo-900/30 border-l-4 border-indigo-500 p-4 my-6 rounded-r-lg"
                >
                    <p class="text-sm">
                        <strong class="text-indigo-300">Analogia:</strong> É como
                        compactar a massa de dez sóis no tamanho de uma cidade como
                        São Paulo. O resultado é um campo gravitacional que deforma
                        o tecido do espaço e do tempo ao seu redor de forma irreversível.
                    </p>
                </div>

                <h3 class="text-xl font-semibold text-white mt-8 mb-4">
                    Anatomia do Abismo
                </h3>
                <ul class="space-y-4">
                    <li class="flex items-start gap-3">
                        <div
                            class="mt-1.5 w-2 h-2 rounded-full bg-white shadow-[0_0_10px_white] shrink-0"
                        ></div>
                        <div>
                            <strong class="text-indigo-200"
                                >Horizonte de Eventos:</strong
                            > O ponto de não retorno. A esfera preta central que
                            você vê na visualização. Cruzou essa linha, você pertence
                            ao buraco negro para sempre.
                        </div>
                    </li>
                    <li class="flex items-start gap-3">
                        <div
                            class="mt-1.5 w-2 h-2 rounded-full bg-purple-500 shadow-[0_0_10px_purple] shrink-0"
                        ></div>
                        <div>
                            <strong class="text-purple-300"
                                >Singularidade:</strong
                            > O centro teórico. Um ponto de densidade infinita e
                            volume zero onde as leis da física como conhecemos deixam
                            de fazer sentido.
                        </div>
                    </li>
                    <li class="flex items-start gap-3">
                        <div
                            class="mt-1.5 w-2 h-2 rounded-full bg-orange-500 shadow-[0_0_10px_orange] shrink-0"
                        ></div>
                        <div>
                            <strong class="text-orange-300"
                                >Disco de Acreção:</strong
                            > O anel brilhante e quente de gás e poeira girando em
                            velocidades próximas à da luz. O atrito gera tanto calor
                            que o disco brilha em raios-X, tornando o buraco negro
                            visível indiretamente.
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
                2. Gigantes da Ciência: Uma Linha do Tempo
            </h2>
            <p class="text-gray-300 mb-8">
                A compreensão desses monstros cósmicos não aconteceu da noite
                para o dia. Foi uma construção de séculos.
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
                        O Visionário: John Michell
                    </h3>
                    <p class="text-gray-300 text-sm leading-relaxed">
                        Um clérigo e astrônomo inglês que propôs pela primeira
                        vez a ideia de "estrelas escuras". Usando a física
                        newtoniana, ele calculou que uma estrela poderia ser tão
                        massiva que sua velocidade de escape superaria a da luz.
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
                        O Arquiteto: Albert Einstein
                    </h3>
                    <p class="text-gray-300 text-sm leading-relaxed">
                        Sua Teoria da Relatividade Geral criou a fundação para
                        eles. Einstein mostrou que a gravidade não é uma "força"
                        mágica, mas a curvatura do espaço-tempo causada pela
                        massa.
                        <br /><br />
                        <span class="italic text-white/80"
                            >"A matéria diz ao espaço como se curvar. O espaço
                            diz à matéria como se mover."</span
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
                        O Solucionador: Karl Schwarzschild
                    </h3>
                    <p class="text-gray-300 text-sm leading-relaxed">
                        Meses após a publicação de Einstein, Schwarzschild
                        encontrou a primeira solução exata para as equações,
                        prevendo o tamanho exato que algo precisa ser comprimido
                        para virar um buraco negro.
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
                        A Era de Ouro
                    </h3>
                    <ul class="text-gray-300 text-sm leading-relaxed space-y-2">
                        <li>
                            <strong class="text-indigo-200"
                                >John Wheeler:</strong
                            > Popularizou o termo "buraco negro".
                        </li>
                        <li>
                            <strong class="text-indigo-200"
                                >Roger Penrose:</strong
                            > Provou que singularidades são inevitáveis no colapso
                            gravitacional.
                        </li>
                        <li>
                            <strong class="text-indigo-200"
                                >Stephen Hawking:</strong
                            > Mostrou que buracos negros emitem radiação ("Radiação
                            Hawking").
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
                        A Imagem: Colaboração EHT
                    </h3>
                    <p class="text-gray-300 text-sm leading-relaxed">
                        Uma rede global de radiotelescópios capturou a primeira
                        imagem direta da sombra de um buraco negro supermassivo
                        em M87.
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
                3. A Linguagem Matemática do Cosmos
            </h2>
            <p class="text-gray-300">
                Não precisamos ser físicos para apreciar a beleza das equações
                que descrevem esses monstros.
            </p>

            <!-- Schwarzschild Radius -->
            <div class="bg-gray-900/50 rounded-xl p-6 border border-white/5">
                <h3 class="text-xl font-semibold text-white mb-4">
                    O Raio de Schwarzschild
                </h3>
                <p class="text-gray-400 text-sm mb-6">
                    Esta equação define o tamanho da "boca" do buraco negro.
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
                        <span class="text-indigo-300 font-bold">Rs</span> : Raio
                        do horizonte
                    </div>
                    <div>
                        <span class="text-indigo-300 font-bold">M</span> : Massa
                        do objeto
                    </div>
                    <div>
                        <span class="text-indigo-300 font-bold">G</span> : Constante
                        gravitacional
                    </div>
                    <div>
                        <span class="text-indigo-300 font-bold">c</span> : Velocidade
                        da luz
                    </div>
                </div>
            </div>

            <!-- Einstein Field Equations -->
            <div
                class="bg-gray-900/50 rounded-xl p-6 border border-white/5 mt-8"
            >
                <h3 class="text-xl font-semibold text-white mb-4">
                    Equações de Campo de Einstein
                </h3>
                <p class="text-gray-400 text-sm mb-6">
                    A base de toda a cosmologia moderna.
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
                            >Lado Esquerdo (G<sub>&mu;&nu;</sub>):</strong
                        > Descreve a geometria (curvatura) do espaço-tempo.
                    </p>
                    <p>
                        <strong class="text-white"
                            >Lado Direito (T<sub>&mu;&nu;</sub>):</strong
                        > Descreve a distribuição de matéria e energia.
                    </p>
                    <p class="italic text-indigo-300 text-center mt-4">
                        "A presença de massa curva o universo ao seu redor".
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
                4. Por Que Isso Importa?
            </h2>

            <div class="grid md:grid-cols-2 gap-6">
                <div
                    class="bg-white/5 p-6 rounded-xl hover:bg-white/10 transition-colors"
                >
                    <h3 class="text-lg font-bold text-white mb-2">
                        1. O Laboratório Definitivo
                    </h3>
                    <p class="text-sm text-gray-300">
                        O único lugar onde a Relatividade Geral e a Mecânica
                        Quântica colidem. A chave para a "Teoria de Tudo".
                    </p>
                </div>

                <div
                    class="bg-white/5 p-6 rounded-xl hover:bg-white/10 transition-colors"
                >
                    <h3 class="text-lg font-bold text-white mb-2">
                        2. Tecnologia GPS
                    </h3>
                    <p class="text-sm text-gray-300">
                        Sistemas GPS dependem das correções relativísticas de
                        Einstein. Sem elas, a precisão cairia quilômetros por
                        dia.
                    </p>
                </div>

                <div
                    class="bg-white/5 p-6 rounded-xl hover:bg-white/10 transition-colors"
                >
                    <h3 class="text-lg font-bold text-white mb-2">
                        3. Ondas Gravitacionais
                    </h3>
                    <p class="text-sm text-gray-300">
                        Desde 2015, podemos "ouvir" colisões de buracos negros,
                        uma nova janela para observar o invisível.
                    </p>
                </div>

                <div
                    class="bg-white/5 p-6 rounded-xl hover:bg-white/10 transition-colors"
                >
                    <h3 class="text-lg font-bold text-white mb-2">
                        4. Filosofia
                    </h3>
                    <p class="text-sm text-gray-300">
                        Eles representam o limite do conhecimento e nos forçam a
                        confrontar a vastidão e estranheza do universo.
                    </p>
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
