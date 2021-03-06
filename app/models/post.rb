class Post < ApplicationRecord

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  belongs_to :user

  validates :title, :presence => true
  validates :body, :presence => true

end
