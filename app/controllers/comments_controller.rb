class CommentsController < ApplicationController

  include ApplicationHelper

  before_action :require_user
  before_action :set_parent, only: [:new, :create]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    @comment = @parent.comments.build
  end

  def create
    @comment = @parent.comments.create(comment_params)
    redirect_to @comment.post
  end

  def edit
    redirect_non_owner_user @comment
  end

  def update
    if user_owner_of?(@comment)
      @comment.update_attributes(comment_params) ? redirect_to(@comment.post) : redirect_to(new)
    end
  end

  def destroy
    if user_owner_of?(@comment)
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to redirect_to_post }
        format.js { render 'destroy' }
      end
    end
  end

  private

  def redirect_to_post
    redirect_to post_path(Post.find(params[:post_id]))
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

  def set_parent
    @parent = Post.find_by_id(params[:post_id]) if params[:post_id]
    @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    redirect_to root_path unless defined?(@parent)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
