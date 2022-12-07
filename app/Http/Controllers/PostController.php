<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use App\Http\Requests\Post\StoreRequest;
use App\Http\Requests\Post\UpdateRequest;
use App\Models\Post;
use App\Service\PostService;

class PostController extends Controller
{
    public function index(PostService $appService)
    {
        $posts = $appService->getPosts();
        return inertia('Post/Index', compact('posts'));
    }

    public function show(Post $post)
    {
        return inertia('Post/Show', compact('post'));
    }

    public function edit(Post $post)
    {
        return inertia('Post/Edit', compact('post'));
    }

    public function store(StoreRequest $request, PostService $postService)
    {
        $postService->createPost($request->validated());
        return redirect()->route('post.index');
    }

    public function create()
    {
        return inertia('Post/Create');
    }

    public function update(Post $post, UpdateRequest $request, PostService $postService)
    {
        $postService->updatePost($post, $request->validated());
        return redirect()->route('post.index');
    }

    public function delete(Post $post, PostService $postService)
    {
        $postService->deletePost($post);
        return redirect()->route('post.index');
    }
}
