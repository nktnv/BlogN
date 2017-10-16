module VotesHelper

  def all_votes(obj, type)
    obj.votes.where(attitude: type).size
  end

  def user_vote(obj)
    obj.votes.where(user_id: current_user.id).first
  end

  def user_voted?(obj, type)
    obj.votes.where(user_id: current_user.id).where(attitude: type).size == 1
  end

  def current_user_voted?(obj)
    obj.votes.exists?(user_id: current_user.id)
  end

end
