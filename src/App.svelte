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
  import Nebula from "./components/Nebula.svelte";
  import NebulaJourney from "./components/NebulaJourney.svelte";

  // Inicializa o suporte a idiomas
  import { i18n, _ } from "./lib/i18n";
  i18n.initialize();

  type SceneType = "blackhole" | "neutronstar" | "saturn" | "nebula";
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
  {:else if currentScene === "nebula"}
    <Nebula />
  {/if}
</div>

{#if currentScene === "blackhole"}
  <EducationalJourney />
{:else if currentScene === "neutronstar"}
  <NeutronJourney />
{:else if currentScene === "saturn"}
  <SaturnJourney />
{:else if currentScene === "nebula"}
  <NebulaJourney />
{/if}

<AudioPlayer />

<!-- Navigation UI -->
<div
  class="fixed top-16 md:top-6 left-0 right-0 z-20 flex justify-center w-full pointer-events-none"
>
  <div
    class="flex gap-2 md:gap-3 overflow-x-auto px-4 max-w-full pointer-events-auto no-scrollbar justify-start md:justify-center items-center py-2"
  >
    <button
      class="px-3 py-1.5 md:px-5 md:py-2 rounded-full backdrop-blur-md border transition-all duration-300 cursor-pointer text-[9px] md:text-[10px] whitespace-nowrap font-mono uppercase tracking-[0.2em] shrink-0
          {currentScene === 'blackhole'
        ? 'bg-indigo-500/40 border-indigo-400 text-white shadow-[0_0_20px_rgba(99,102,241,0.3)]'
        : 'bg-black/70 border-white/20 text-gray-200 hover:bg-black/80 hover:border-white/40'}"
      onclick={() => switchScene("blackhole")}
    >
      {$_("nav.blackhole")}
    </button>
    <button
      class="px-3 py-1.5 md:px-5 md:py-2 rounded-full backdrop-blur-md border transition-all duration-300 cursor-pointer text-[9px] md:text-[10px] whitespace-nowrap font-mono uppercase tracking-[0.2em] shrink-0
          {currentScene === 'neutronstar'
        ? 'bg-cyan-500/40 border-cyan-400 text-white shadow-[0_0_20px_rgba(34,211,238,0.3)]'
        : 'bg-black/70 border-white/20 text-gray-200 hover:bg-black/80 hover:border-white/40'}"
      onclick={() => switchScene("neutronstar")}
    >
      {$_("nav.neutronstar")}
    </button>
    <button
      class="px-3 py-1.5 md:px-5 md:py-2 rounded-full backdrop-blur-md border transition-all duration-300 cursor-pointer text-[9px] md:text-[10px] whitespace-nowrap font-mono uppercase tracking-[0.2em] shrink-0
          {currentScene === 'saturn'
        ? 'bg-amber-500/40 border-amber-400 text-white shadow-[0_0_20px_rgba(251,191,36,0.3)]'
        : 'bg-black/70 border-white/20 text-gray-200 hover:bg-black/80 hover:border-white/40'}"
      onclick={() => switchScene("saturn")}
    >
      {$_("nav.saturn")}
    </button>
    <button
      class="px-3 py-1.5 md:px-5 md:py-2 rounded-full backdrop-blur-md border transition-all duration-300 cursor-pointer text-[9px] md:text-[10px] whitespace-nowrap font-mono uppercase tracking-[0.2em] shrink-0
          {currentScene === 'nebula'
        ? 'bg-purple-500/40 border-purple-400 text-white shadow-[0_0_20px_rgba(168,85,247,0.3)]'
        : 'bg-black/70 border-white/20 text-gray-200 hover:bg-black/80 hover:border-white/40'}"
      onclick={() => switchScene("nebula")}
    >
      {$_("nav.nebula")}
    </button>
  </div>
</div>

<div
  class="fixed top-4 right-4 z-50 flex gap-4 bg-black/30 backdrop-blur-sm p-2 rounded-full border border-white/10"
>
  <LanguageSelector />
  <ThemeToggle />
</div>

<main class="sr-only">
  <h1>{$_("common.app_title")}</h1>
</main>
