module Api
  class PostsController < ApplicationController
    def index
      @posts = Post.all.order(created_at: :desc)
      render json: @posts
    end

    def create
      @post = Post.new(post_params)
      @post.user = current_user
      
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :sub, :content, :img)
    end
  end
end