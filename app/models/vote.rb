class Vote < ApplicationRecord

  belongs_to :voteable, polymorphic: true
  belongs_to :user, optional: true
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  enum attitude: [:like, :dislike]

  validates :user_id, :presence => true,
            :uniqueness => {:scope => [:voteable_id, :voteable_type], :message => 'user has already the item'}
  validates :voteable_id, :presence => true,
            :uniqueness => {:scope => [:user_id, :voteable_type], :message => 'user has already the item'}
  validates :voteable_type, :presence => true,
            :uniqueness => {:scope => [:voteable_id, :user_id], :message => 'user has already the item'}

  def post
    voteable.is_a?(Post) ? voteable : voteable.post
  end

end
