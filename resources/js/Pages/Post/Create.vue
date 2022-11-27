
<template>
       <h1 class="text-lg mb-6 ">Create</h1>
    <Link :href="route('post.index')" class="text-sky-500" > Назад </Link>
   <form @submit.prevent="store">
       <div class="mb-4">
           <di v-if="errors.title" class="text-red-600">{{errors.title}}</di>
           <input id="title" v-model="this.title" class="w-full rounded-full border-gray-300" type="text"
                  placeholder="title">
       </div>
       <div>
           <di v-if="errors.content" class="text-red-600">{{errors.content}}</di>
           <textarea id="content" v-model="this.content" class="w-full rounded-full border-gray-300"
                     placeholder="content"></textarea>
       </div>
       <div class="mb-4">
           <button
               class="ml-auto hover:bg-white hover:text-sky-500 block p-2 w-32 bg-sky-500 border border-sky-500 rounded-full text-center text-white" type="submit">Store</button>
       </div>
   </form>
    <RedaktorExample />
</template>

<script>
import { reactive } from 'vue'
import RedaktorExample from '@/Components/RedaktorExample.vue';
import { Inertia } from '@inertiajs/inertia'
import PostLayout from "@/Layouts/PostLayout.vue";
import { Link } from '@inertiajs/inertia-vue3'

export default {
    name: "Create",
    layout: PostLayout,
    components: {
        RedaktorExample,
        Link
    },
    props: ['errors'],
    data() {
        return {
            title: '',
            content: '',
        }
    },
    methods: {
        store() {
            //console.log(this.title)
            this.$inertia.post(`/posts`, {title: this.title, content: this.content})
        }
    }

}
</script>
