class CommentsController < ApplicationController

  before_action :find_post

  def create
    @comment = @post.comments.create(comment_params)
    redirect_to_post
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to_post
  end

  private

  def redirect_to_post
    redirect_to post_path(@post)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
