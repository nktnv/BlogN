class Comment < ApplicationRecord

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  belongs_to :user

  validates :body, :presence => true

  def post
    commentable.is_a?(Post) ? commentable : commentable.post
  end

end
