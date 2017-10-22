class User < ApplicationRecord

  has_secure_password

  has_many :posts
  has_many :comments
  has_many :votes
  has_one :image

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true

end
