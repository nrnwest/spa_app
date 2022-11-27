<template>
   <h1 class="text-lg mb-8">Post</h1>
    <Link :href="route('post.index')" class="text-sky-500" > Назад </Link>
    <div v-if="post">
   <div class="mt-8 pt-8 border-t border-gray-300">
       <div>id: {{post.id}}</div>
       <div>title: {{post.title}}</div>
       <div>content: {{post.content}}</div>
       <div class="text-sm text-right"> {{post.date}}</div>
   </div>
    </div>
</template>

<script>
import { Link } from '@inertiajs/inertia-vue3'
import PostLayout from "@/Layouts/PostLayout.vue";

export default {
    name: "Show",
    layout: PostLayout,
    props: [
        'post'
    ],
    components: {
        Link
    }
}
</script>

<style scoped>

</style>
