<script lang="ts">
  import "./styles/global.css";
  import ThemeToggle from "./components/ThemeToggle.svelte";
  import LanguageSelector from "./components/LanguageSelector.svelte";
  import BlackHole from "./components/BlackHole.svelte";
  import AudioPlayer from "./components/AudioPlayer.svelte";
  import EducationalJourney from "./components/EducationalJourney.svelte";

  // Inicializa o suporte a idiomas
  import { i18n } from "./lib/i18n";
  i18n.initialize();
</script>

<div class="fixed inset-0 z-0">
  <BlackHole />
</div>

<EducationalJourney />

<AudioPlayer />

<div class="fixed top-4 right-4 z-10 flex gap-4">
  <LanguageSelector />
  <ThemeToggle />
</div>

<main class="sr-only">
  <h1>Black Hole Visualization</h1>
</main>
