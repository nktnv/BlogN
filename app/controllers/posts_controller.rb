class PostsController < ApplicationController

  include ApplicationHelper

  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    @post.save ? redirect_to(posts_path) : redirect_to(new)
  end

  def edit
    redirect_non_owner_user(@post)
  end

  def update
    if user_owner_of?(@post)
      @post.update_attributes(post_params) ? redirect_to(@post) : redirect_to(new)
    end
  end

  def destroy
    if user_owner_of?(@post)
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.js { render 'destroy' }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
