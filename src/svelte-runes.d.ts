/// <reference types="svelte" />

declare global {
    const $state: typeof import('svelte')['$state'];
    const $derived: typeof import('svelte')['$derived'];
    const $effect: typeof import('svelte')['$effect'];
    const $props: typeof import('svelte')['$props'];
    const $inspect: typeof import('svelte')['$inspect'];
    const $host: typeof import('svelte')['$host'];
}

export { };
