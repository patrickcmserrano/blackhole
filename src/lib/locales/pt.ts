export default {
  "nav": {
    "blackhole": "Buraco Negro",
    "neutronstar": "Estrela de Nêutrons",
    "saturn": "Saturno",
    "nebula": "Nebulosa"
  },
  "common": {
    "scroll_hint": "Explore o universo abaixo",
    "author": "Patrick Serrano",
    "date": "24/01/2026",
    "app_title": "Visualização Interativa do Universo",
    "audio_on": "Áudio Ligado",
    "audio_off": "Áudio Desligado",
    "loading": "Carregando...",
    "audio_unavailable": "Indisponível"
  },
  "blackhole": {
    "title_main": "No Limite da Realidade",
    "title_sub": "Uma Jornada aos Buracos Negros",
    "description": "Uma exploração visual e interativa sobre a física, história e mistério dos buracos negros, potencializada por Three.js.",
    "tags": ["Astrofísica", "Educação", "Three.js", "Interativo"],
    "section1": {
      "title": "1. O Que é um Buraco Negro?",
      "subtitle": "O Derradeiro Ralo Cósmico",
      "p1": "Imagine um lugar onde a gravidade é tão intensa que nada, absolutamente nada, consegue escapar. Nem foguetes, nem partículas, nem mesmo a luz — a coisa mais rápida do universo. Esse lugar é um buraco negro.",
      "p2": "Eles não são \"buracos\" no sentido tradicional, mas sim quantidades imensas de matéria espremida em um espaço incrivelmente pequeno.",
      "analogy": "Analogia: É como compactar a massa de dez sóis no tamanho de uma cidade como São Paulo. O resultado é um campo gravitacional que deforma o tecido do espaço e do tempo ao seu redor de forma irreversível.",
      "anatomy_title": "Anatomia do Abismo",
      "event_horizon": "Horizonte de Eventos:",
      "event_horizon_desc": "O ponto de não retorno. A esfera preta central que você vê na visualização. Cruzou essa linha, você pertence ao buraco negro para sempre.",
      "singularity": "Singularidade:",
      "singularity_desc": "O centro teórico. Um ponto de densidade infinita e volume zero onde as leis da física como conhecemos deixam de fazer sentido.",
      "accretion_disk": "Disco de Acreção:",
      "accretion_disk_desc": "O anel brilhante e quente de gás e poeira girando em velocidades próximas à da luz. O atrito gera tanto calor que o disco brilha em raios-X, tornando o buraco negro visível indiretamente."
    },
    "section2": {
      "title": "2. Gigantes da Ciência: Uma Linha do Tempo",
      "p1": "A compreensão desses monstros cósmicos não aconteceu da noite para o dia. Foi uma construção de séculos.",
      "year_1783_title": "O Visionário: John Michell",
      "year_1783_desc": "Um clérigo e astrônomo inglês que propôs pela primeira vez a ideia de \"estrelas escuras\". Usando a física newtoniana, ele calculou que uma estrela poderia ser tão massiva que sua velocidade de escape superaria a da luz.",
      "year_1915_title": "O Arquiteto: Albert Einstein",
      "year_1915_desc": "Sua Teoria da Relatividade Geral criou a fundação para eles. Einstein mostrou que a gravidade não é uma \"força\" mágica, mas a curvatura do espaço-tempo causada pela massa.",
      "einstein_quote": "\"A matéria diz ao espaço como se curvar. O espaço diz à matéria como se mover.\"",
      "year_1916_title": "O Solucionador: Karl Schwarzschild",
      "year_1916_desc": "Meses após a publicação de Einstein, Schwarzschild encontrou a primeira solução exata para as equações, prevendo o tamanho exato que algo precisa ser comprimido para virar um buraco negro.",
      "era_golden_title": "A Era de Ouro",
      "wheeler_name": "John Wheeler:",
      "wheeler_desc": "Popularizou o termo \"buraco negro\".",
      "penrose_name": "Roger Penrose:",
      "penrose_desc": "Provou que singularidades são inevitáveis no colapso gravitacional.",
      "hawking_name": "Stephen Hawking:",
      "hawking_desc": "Mostrou que buracos negros emitem radiação (\"Radiação Hawking\").",
      "year_2019_title": "A Imagem: Colaboração EHT",
      "year_2019_desc": "Uma rede global de radiotelescópios capturou a primeira imagem direta da sombra de um buraco negro supermassivo em M87."
    },
    "section3": {
      "title": "3. A Linguagem Matemática do Cosmos",
      "p1": "Não precisamos ser físicos para apreciar a beleza das equações que descrevem esses monstros.",
      "schwarzschild_title": "O Raio de Schwarzschild",
      "schwarzschild_desc": "Esta equação define o tamanho da \"boca\" do buraco negro.",
      "rs": "Raio do horizonte",
      "m": "Massa do objeto",
      "g": "Constante gravitacional",
      "c": "Velocidade da luz",
      "einstein_eq_title": "Equações de Campo de Einstein",
      "einstein_eq_desc": "A base de toda a cosmologia moderna.",
      "left_side": "Lado Esquerdo (Gμν):",
      "left_side_desc": "Descreve a geometria (curvatura) do espaço-tempo.",
      "right_side": "Lado Direito (Tμν):",
      "right_side_desc": "Descreve a distribuição de matéria e energia.",
      "einstein_summary": "\"A presença de massa curva o universo ao seu redor\"."
    },
    "section4": {
      "title": "4. Por Que Isso Importa?",
      "item1_title": "1. O Laboratório Definitivo",
      "item1_desc": "O único lugar onde a Relatividade Geral e a Mecânica Quântica colidem. A chave para a \"Teoria de Tudo\".",
      "item2_title": "2. Tecnologia GPS",
      "item2_desc": "Sistemas GPS dependem das correções relativísticas de Einstein. Sem elas, a precisão cairia quilômetros por dia.",
      "item3_title": "3. Ondas Gravitacionais",
      "item3_desc": "Desde 2015, podemos \"ouvir\" colisões de buracos negros, uma nova janela para observar o invisível.",
      "item4_title": "4. Filosofia",
      "item4_desc": "Eles representam o limite do conhecimento e nos forçam a confrontar a vastidão e estranheza do universo."
    },
    "section5": {
      "title": "5. Bastidores do Código",
      "intro": "Essa visualização roda inteiramente no seu navegador, usando WebGL para renderização em tempo real.",
      "item1_title": "Shaders & GLSL",
      "item1_desc": "Não usamos imagens estáticas. O anel e o disco são gerados matematicamente pixel por pixel usando shaders, permitindo controle total sobre a luz e cor.",
      "item2_title": "Ruído Procedural",
      "item2_desc": "A textura de 'fogo' do disco de acreção é criada com algoritmos de ruído (Perlin/Simplex Noise), garantindo um movimento orgânico e contínuo.",
      "item3_title": "Pós-Processamento",
      "item3_desc": "O brilho etéreo (Bloom) é aplicado após a renderização da cena, simulando como câmeras reais reagem a fontes de luz intensa."
    }
  },
  "neutron": {
    "title_main": "Estrelas de Nêutrons",
    "title_sub": "A Rainha da Densidade",
    "description": "Uma viagem ao objeto mais denso do cosmos, onde a matéria é esmagada ao limite e campos magnéticos desafiam a imaginação.",
    "tags": ["Astrofísica", "Pulsar", "Three.js", "Magnetismo"],
    "scroll_hint": "Observe o farol cósmico",
    "section1": {
      "title": "1. O Cadáver Estelar",
      "p1": "Quando uma estrela gigante morre em uma supernova, mas não é massiva o suficiente para virar um buraco negro, ela vira isso: uma bola de nêutrons puros.",
      "density_title": "Densidade Inconcevível:",
      "density_desc": "Imagine espremer a massa de 1,5 Sóis dentro de uma esfera do tamanho da ilha de Manhattan (aprox. 20km). Uma colher de chá dessa matéria pesaria tanto quanto o Monte Everest.",
      "crust_title": "A Crosta de Ferro",
      "crust_p": "Ao contrário de estrelas normais gasosas, elas possuem uma crosta sólida, 10 bilhões de vezes mais dura que o aço. \"Montanhas\" nessa superfície teriam apenas alguns milímetros de altura devido à gravidade esmagadora."
    },
    "section2": {
      "title": "2. O Farol Cósmico (Pulsares)",
      "p1": "Muitas estrelas de nêutrons giram insanamente rápido — centenas de vezes por segundo. Elas emitem feixes de radiação pelos polos magnéticos.",
      "p2": "Como o eixo magnético nem sempre alinha com o eixo de rotação, esses feixes varrem o céu. Se a Terra estiver no caminho, vemos um \"pulso\" de luz regular, como um farol marítimo. Daí o nome: Pulsar."
    },
    "section3": {
      "title": "3. Magnetismo Extremo",
      "magnetar_title": "Magnetars",
      "magnetar_desc": "Algumas estrelas de nêutrons, chamadas Magnetars, possuem os campos magnéticos mais fortes do universo.",
      "earth": "Terra:",
      "fridge_magnet": "Ímã de Geladeira:",
      "mri": "Ressonância Magnética:",
      "magnetar": "Magnetar:",
      "magnetar_warning": "Esse campo é tão forte que, a 1000km de distância, ele distorceria os átomos do seu corpo, transformando sua química em algo impossível de sustentar a vida."
    }
  },
  "saturn": {
    "title_main": "O Senhor dos Anéis",
    "title_sub": "A Grandeza de Saturno",
    "description": "Uma viagem visual ao gigante gasoso, seus anéis de gelo e as luas que guardam segredos de vida.",
    "tags": ["Sistema Solar", "Cassini", "Astronomia", "Three.js"],
    "scroll_hint": "Explore os anéis",
    "section1": {
      "title": "1. Não é um Disco Sólido",
      "p1": "Embora pareçam sólidos vistos da Terra, os anéis de Saturno são, na verdade, compostos por bilhões de pedaços de gelo e rocha.",
      "p2": "O tamanho dessas partículas varia de grãos de poeira a montanhas inteiras. A visualização que você vê usa milhares de pequenas rochas simuladas individualmente para recriar essa dispersão.",
      "fact_title": "Fato Surpreendente:",
      "fact_desc": "Apesar de terem milhares de quilômetros de largura, os anéis são incrivelmente finos — em média, têm apenas cerca de 10 metros de espessura."
    },
    "section2": {
      "title": "2. As Luas Pastoras e a Vida",
      "p1": "Saturno não reina sozinho. Ele é acompanhado por uma corte de dezenas de luas. Algumas, chamadas de Luas Pastoras, orbitam dentro ou perto dos anéis, usando sua gravidade para manter as partículas de gelo em ordem, criando as falhas visíveis entre os anéis.",
      "enceladus_title": "Encélado: Onde a Vida Pode Existir",
      "enceladus_p": "Uma das luas mais fascinantes é Encélado. Coberta por uma camada de gelo branco brilhante, ela esconde um oceano global de água líquida abaixo da superfície. Gêiseres gigantes cospem água no espaço, sugerindo que este pequeno mundo pode ter todos os ingredientes necessários para a vida."
    },
    "section3": {
      "title": "3. O Legado da Cassini",
      "p1": "Muito do que sabemos hoje vem da missão Cassini-Huygens (1997-2017). Durante 13 anos, a sonda orbitou Saturno, enviando imagens deslumbrantes e dados revolucionários.",
      "p2": "Em seu \"Grand Finale\", a Cassini mergulhou corajosamente no espaço estreito entre o planeta e seus anéis, antes de se desintegrar na atmosfera de Saturno para proteger as luas de contaminação terrestre."
    }
  },
  "nebula": {
    "title_main": "Berçários Cósmicos",
    "title_sub": "Nebulosas",
    "description": "Onde as estrelas nascem. Uma nuvem colossal de gás e poeira esculpida pela radiação de estrelas recém-nascidas.",
    "tags": ["Nebulosa", "Formação Estelar", "Química Cósmica"],
    "scroll_hint": "Mergulhe na nuvem",
    "section1": {
      "title": "1. Nuvens de Possibilidades",
      "p1": "Uma nebulosa não tem superfície sólida. É uma nuvem gigantesca de gás (principalmente hidrogênio) e poeira cósmica. A visualização que você vê usa milhares de pontos de luz transparentes para simular esse efeito volumétrico.",
      "p2": "Algumas dessas nuvens, como os famosos \"Pilares da Criação\", têm anos-luz de altura. São verdadeiras fábricas de estrelas."
    },
    "section2": {
      "title": "2. A Química da Cor",
      "p1": "As cores vibrantes das nebulosas não são \"pintadas\"; elas são a assinatura química dos elementos sendo ionizados pela radiação intensa das estrelas próximas.",
      "pink_title": "Rosa/Vermelho:",
      "pink_desc": "A cor mais comum, causada pelo Hidrogênio brilhando.",
      "cyan_title": "Azul/Verde:",
      "cyan_desc": "Geralmente indica a presença de Oxigênio (OIII)."
    },
    "section3": {
      "title": "3. O Colapso",
      "p1": "Dentro dessas nuvens escuras e frias, a gravidade começa a vencer. Aglomerados de gás começam a se colapsar sob o próprio peso, ficando cada vez mais quentes e densos, até que... FUSÃO NUCLEAR. Uma estrela nasce, iluminando a nuvem ao seu redor de dentro para fora."
    }
  }
};