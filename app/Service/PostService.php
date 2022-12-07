<?php

declare(strict_types=1);

namespace App\Service;

use App\Http\Resources\Post\PostResuorce;
use App\Models\Post;

class PostService
{
    public function getPosts(): array
    {
        $posts = Post::all();
        return PostResuorce::collection($posts)->resolve();
    }

    public function createPost(array $data): Post
    {
        return Post::create($data);
    }

    public function updatePost(Post $post, array $data): void
    {
        $post->update($data);
    }

    public function deletePost(Post $post): void
    {
        $post->delete();
    }
}
