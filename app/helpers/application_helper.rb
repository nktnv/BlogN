module ApplicationHelper

  def user_owner_of?(obj)
    current_user && current_user.id == obj[:user_id]
  end

end
