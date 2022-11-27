<template>
    <h1 class="text-lg mb-6 ">Edit</h1>
    <Link :href="route('post.index')" class="text-sky-500"> Назад</Link>
    <form @submit.prevent="update">
        <div class="mb-4">
            <di v-if="errors.title" class="text-red-600">{{errors.title}}</di>
            <input id="title" v-model="title" class="w-full rounded-full border-gray-300" type="text"
                   placeholder="title">
        </div>
        <div>
            <di v-if="errors.content" class="text-red-600">{{errors.content}}</di>
            <textarea id="content" v-model="content" class="w-full rounded-full border-gray-300"
                      placeholder="content"></textarea>
        </div>
        <div class="mb-4">
            <button
                class="ml-auto hover:bg-white hover:text-sky-500 block p-2 w-32 bg-sky-500 border border-sky-500 rounded-full text-center text-white"
                type="submit">Update
            </button>
        </div>
    </form>
    <RedaktorExample/>
</template>

<script>
import RedaktorExample from '@/Components/RedaktorExample.vue';
import PostLayout from "@/Layouts/PostLayout.vue";
import {Link} from '@inertiajs/inertia-vue3'

export default {
    name: "Edit",
    components: {
        RedaktorExample,
        Link
    },
    layout: PostLayout,
    props: ['post', 'errors'],
    data() {
        return {
            id: this.post.id,
            title: this.post.title,
            content: this.post.content,
        }
    },
    methods: {
        update() {
            //console.log(this.title)
           this.$inertia.patch(`/posts/${this.id}`, {title: this.title, content: this.content})
        }
    }
}
</script>
