module Api
  class PostsController < ApplicationController
    before_action :authenticate_user, only: [:create, :update, :destroy]
    before_action :set_post, only: [:show, :update, :destroy]
    before_action :check_post_owner, only: [:update, :destroy]
 
    def index
      @posts = Post.all.order(created_at: :desc)
      render json: @posts
    end
 
    def create
      @post = Post.new(post_params)
      @post.user = current_user
      @post.date = Date.today
      
      if @post.save
        render json: @post, status: :created
      else
        render json: { error: @post.errors.full_messages }, status: :unprocessable_entity
      end
    end
 
    def show
      render json: @post
    rescue ActiveRecord::RecordNotFound
      render json: { error: '게시물을 찾을 수 없습니다' }, status: :not_found
    end
 
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: { error: @post.errors.full_messages }, status: :unprocessable_entity
      end
    end
 
    def destroy
      @post.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { error: '게시물을 찾을 수 없습니다' }, status: :not_found
    end
 
    private
 
    def set_post
      @post = Post.find(params[:id])
    end
 
    def post_params
      params.require(:post).permit(:title, :sub, :content, :image)
    end
 
    def check_post_owner
      unless @post.user_id == current_user&.id
        render json: { error: "이 작업을 수행할 권한이 없습니다" }, status: :forbidden
      end
    end
  end
 end