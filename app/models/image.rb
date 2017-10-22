class Image < ApplicationRecord

  belongs_to :user

  validates :picture, :presence => true

end
