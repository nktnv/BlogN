class PostsController < ApplicationController

  include ApplicationHelper

  before_action :require_user, only: [:new, :create, :edit, :update, :destroy, :index_users_posts]
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
    if @post.save
      redirect_to(posts_path)
      flash[:success] = 'Post was created successfully.'
    else
      redirect_to(new_post_path)
      flash[:error] = 'Title and Body fields are mandatory.'
    end
  end

  def edit
    redirect_non_owner_user(@post)
  end

  def update
    if user_owner_of?(@post)
      if @post.update_attributes(post_params) && @post.save
        redirect_to(@post)
        flash[:success] = 'Post was updated successfully.'
      else
        redirect_to(edit_post_path(@post))
        flash[:error] = 'Title and Body fields are mandatory.'
      end
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

  def index_users_posts
    @posts = Post.where(user_id: current_user.id)
  end

  def popular_posts
    posts_array_of_hashes =
      Post.all.map do |post|
        { post.id => post.votes.where(attitude: :like).size }
      end
    posts_hash = posts_array_of_hashes.reduce Hash.new, :merge
    sorted_posts = posts_hash.sort_by { |k, v| -v }
    @posts = sorted_posts[0..4].map { |el| Post.find(el[0]) }
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
