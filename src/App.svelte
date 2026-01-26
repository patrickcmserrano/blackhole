<script lang="ts">
  import "./styles/global.css";
  import ThemeToggle from "./components/ThemeToggle.svelte";
  import LanguageSelector from "./components/LanguageSelector.svelte";
  import BlackHole from "./components/BlackHole.svelte";
  import NeutronStar from "./components/NeutronStar.svelte";
  import AudioPlayer from "./components/AudioPlayer.svelte";
  import EducationalJourney from "./components/EducationalJourney.svelte";
  import NeutronJourney from "./components/NeutronJourney.svelte";
  import Saturn from "./components/Saturn.svelte";
  import SaturnJourney from "./components/SaturnJourney.svelte";

  // Inicializa o suporte a idiomas
  import { i18n } from "./lib/i18n";
  i18n.initialize();

  type SceneType = "blackhole" | "neutronstar" | "saturn";
  let currentScene = $state<SceneType>("blackhole");

  function switchScene(scene: SceneType) {
    currentScene = scene;
  }
</script>

<div class="fixed inset-0 z-0">
  {#if currentScene === "blackhole"}
    <BlackHole />
  {:else if currentScene === "neutronstar"}
    <NeutronStar />
  {:else if currentScene === "saturn"}
    <Saturn />
  {/if}
</div>

{#if currentScene === "blackhole"}
  <EducationalJourney />
{:else if currentScene === "neutronstar"}
  <NeutronJourney />
{:else if currentScene === "saturn"}
  <SaturnJourney />
{/if}

<AudioPlayer />

<!-- Navigation UI -->
<div
  class="fixed top-6 left-1/2 -translate-x-1/2 z-20 flex gap-3 pointer-events-auto"
>
  <button
    class="px-5 py-2 rounded-full backdrop-blur-md border transition-all duration-300 cursor-pointer text-[10px] font-mono uppercase tracking-[0.2em]
        {currentScene === 'blackhole'
      ? 'bg-indigo-500/40 border-indigo-400 text-white shadow-[0_0_20px_rgba(99,102,241,0.3)]'
      : 'bg-black/40 border-white/10 text-gray-400 hover:bg-white/10 hover:border-white/20'}"
    onclick={() => switchScene("blackhole")}
  >
    Buraco Negro
  </button>
  <button
    class="px-5 py-2 rounded-full backdrop-blur-md border transition-all duration-300 cursor-pointer text-[10px] font-mono uppercase tracking-[0.2em]
        {currentScene === 'neutronstar'
      ? 'bg-cyan-500/40 border-cyan-400 text-white shadow-[0_0_20px_rgba(34,211,238,0.3)]'
      : 'bg-black/40 border-white/10 text-gray-400 hover:bg-white/10 hover:border-white/20'}"
    onclick={() => switchScene("neutronstar")}
  >
    Estrela de Nêutrons
  </button>
  <button
    class="px-5 py-2 rounded-full backdrop-blur-md border transition-all duration-300 cursor-pointer text-[10px] font-mono uppercase tracking-[0.2em]
        {currentScene === 'saturn'
      ? 'bg-amber-500/40 border-amber-400 text-white shadow-[0_0_20px_rgba(251,191,36,0.3)]'
      : 'bg-black/40 border-white/10 text-gray-400 hover:bg-white/10 hover:border-white/20'}"
    onclick={() => switchScene("saturn")}
  >
    Saturno
  </button>
</div>

<div class="fixed top-4 right-4 z-10 flex gap-4">
  <LanguageSelector />
  <ThemeToggle />
</div>

<main class="sr-only">
  <h1>Interactive Universe Visualization</h1>
</main>
