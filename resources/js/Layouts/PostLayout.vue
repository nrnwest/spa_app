<script>
import {Link} from '@inertiajs/inertia-vue3'

export default {
    name: "PostLayout",
    components: {
        Link
    }
}
</script>

<template>
    <div class="w-96 mx-auto pt-8">
        <h1 class="mb-6 text-xl text-red-700" >
            <Link class="text-sky-500 text-xl" :href="route('post.index')">Пример Приложения SPA crud</Link></h1>
        <slot/>
    </div>
</template>
