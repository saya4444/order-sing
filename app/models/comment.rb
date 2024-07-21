class Comment < ApplicationRecord

  # バリデーション
  validates :content, presence: true

  # アソシエーション
  belongs_to :user
  belongs_to :list


end
