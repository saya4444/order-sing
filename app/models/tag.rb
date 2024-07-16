class Tag < ApplicationRecord

  # バリデーション
  validates :tag, presence: true, uniqueness: true

  # アソシエーション
  has_many :list_tags, dependent: :destroy
  has_many :lists    , through: :list_tags


end
