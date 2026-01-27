<script lang="ts">
    import { onMount } from "svelte";
    import { _ } from "../lib/i18n";

    let player: any;
    let isPlaying = $state(false);
    let isMuted = $state(true);
    let playerReady = $state(false);
    let playbackError = $state("");

    const videoId = "jqvcqe9KOW0";

    onMount(() => {
        // Load YouTube IFrame Player API
        if (!(window as any).YT) {
            const tag = document.createElement("script");
            tag.src = "https://www.youtube.com/iframe_api";
            const firstScriptTag = document.getElementsByTagName("script")[0];
            firstScriptTag.parentNode?.insertBefore(tag, firstScriptTag);

            (window as any).onYouTubeIframeAPIReady = () => {
                initPlayer();
            };
        } else {
            if ((window as any).YT.Player) {
                initPlayer();
            } else {
                // YT exists but not Player yet, might be loading
                const interval = setInterval(() => {
                    if ((window as any).YT.Player) {
                        clearInterval(interval);
                        initPlayer();
                    }
                }, 100);
            }
        }
    });

    function initPlayer() {
        try {
            const playerConfig = {
                height: "0",
                width: "0",
                videoId: videoId,
                playerVars: {
                    autoplay: 0,
                    controls: 0,
                    disablekb: 1,
                    fs: 0,
                    iv_load_policy: 3,
                    loop: 1,
                    playlist: videoId,
                    modestbranding: 1,
                    rel: 0,
                    showinfo: 0,
                    origin: window.location.origin,
                    enablejsapi: 1,
                },
                events: {
                    onReady: (event: any) => {
                        playerReady = true;
                        event.target.setVolume(20);
                        event.target.mute();
                    },
                    onStateChange: (event: any) => {
                        if (
                            event.data ===
                            (window as any).YT.PlayerState.PLAYING
                        ) {
                            isPlaying = true;
                        } else {
                            isPlaying = false;
                        }
                    },
                    onError: (event: any) => {
                        console.error("YouTube Player Error:", event.data);
                        if (event.data === 150 || event.data === 101) {
                            playbackError = "Restricted";
                            console.warn(
                                "Video is not embeddable (Error 150).",
                            );
                        } else {
                            playbackError = "Error";
                        }
                        playerReady = false;
                    },
                },
            };

            // @ts-ignore
            player = new (window as any).YT.Player(
                "youtube-audio-player",
                playerConfig,
            );
        } catch (error) {
            console.error("Failed to initialize YouTube Player:", error);
        }
    }

    function toggleAudio() {
        if (!playerReady || !player || playbackError) return;

        if (isMuted) {
            player.setVolume(20);
            player.unMute();
            player.playVideo();
            isMuted = false;
        } else {
            player.mute();
            player.pauseVideo();
            isMuted = true;
        }
    }
</script>

<div class="fixed top-6 left-6 z-[100]">
    <button
        onclick={toggleAudio}
        class="group flex items-center gap-3 bg-accent/10 hover:bg-accent/20 border border-accent/50 hover:border-accent text-accent px-4 py-2 rounded-full transition-all duration-300 backdrop-blur-sm disabled:opacity-50 disabled:cursor-not-allowed"
        aria-label={playbackError
            ? $_("common.audio_unavailable")
            : isMuted
              ? $_("common.audio_on")
              : $_("common.audio_off")}
        title={playbackError
            ? $_("common.audio_unavailable")
            : playerReady
              ? isMuted
                  ? $_("common.audio_on")
                  : $_("common.audio_off")
              : $_("common.loading")}
        disabled={!!playbackError}
    >
        <div class="relative w-5 h-5 flex items-center justify-center">
            {#if playbackError}
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="w-full h-full text-red-500"
                >
                    <circle cx="12" cy="12" r="10" />
                    <line x1="15" y1="9" x2="9" y2="15" />
                    <line x1="9" y1="9" x2="15" y2="15" />
                </svg>
            {:else if isMuted}
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="w-full h-full"
                >
                    <path d="M11 5L6 9H2v6h4l5 4V5z" />
                    <line x1="23" y1="9" x2="17" y2="15" />
                    <line x1="17" y1="9" x2="23" y2="15" />
                </svg>
            {:else}
                <div class="flex items-end gap-0.5 h-3">
                    <div class="w-0.5 bg-accent animate-music-bar-1"></div>
                    <div class="w-0.5 bg-accent animate-music-bar-2"></div>
                    <div class="w-0.5 bg-accent animate-music-bar-3"></div>
                </div>
            {/if}
        </div>
        <span class="text-xs font-mono uppercase tracking-widest min-w-[80px]">
            {#if playbackError}
                {$_("common.audio_unavailable")}
            {:else if !playerReady}
                {$_("common.loading")}
            {:else}
                {isMuted ? $_("common.audio_off") : $_("common.audio_on")}
            {/if}
        </span>
    </button>
</div>

<!-- Invisible but present container for the iframe -->
<div
    class="pointer-events-none fixed -top-10 -left-10 opacity-0 w-1 h-1 overflow-hidden"
>
    <div id="youtube-audio-player"></div>
</div>

<style>
    @keyframes music-bar {
        0%,
        100% {
            height: 4px;
        }
        50% {
            height: 12px;
        }
    }

    .animate-music-bar-1 {
        animation: music-bar 0.8s ease-in-out infinite;
    }
    .animate-music-bar-2 {
        animation: music-bar 0.8s ease-in-out infinite 0.2s;
    }
    .animate-music-bar-3 {
        animation: music-bar 0.8s ease-in-out infinite 0.4s;
    }
</style>
