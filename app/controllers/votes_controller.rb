class VotesController < ApplicationController

  before_action :require_user
  before_action :set_parent

  def create
    @vote = @parent.votes.create(vote_params)
    respond_to do |format|
      format.js { render action: 'interact_with_vote.js.erb' }
      format.html { redirect_to @vote.post }
    end
  end

  def update
    set_vote
    value = change_attitude(@vote)
    @vote.update_attributes(attitude: value)
    respond_to do |format|
      format.js { render action: 'interact_with_vote.js.erb' }
      format.html { redirect_to @vote.post }
    end
  end

  def destroy
    @vote = @parent.votes.where(user_id: current_user.id).first
    @vote.destroy
    respond_to do |format|
      format.js { render action: 'interact_with_vote.js.erb' }
      format.html { redirect_to @vote.post }
    end
  end

  private

  def set_parent
    @parent = Post.find_by_id(params[:post_id]) if params[:post_id]
    @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    redirect_to root_path unless defined?(@parent)
  end

  def set_vote
    @vote = Vote.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:attitude, :user_id)
  end

  def change_attitude(vote)
    vote.attitude == 'like' ? 'dislike' : 'like'
  end

end
