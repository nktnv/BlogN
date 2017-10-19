module ApplicationHelper

  def user_owner_of?(obj)
    current_user && current_user.id == obj[:user_id]
  end

  def random_value(chars = 10)
    [*('a'..'z'),*('0'..'9')].shuffle[0, chars].join
  end

end
