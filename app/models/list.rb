class List < ApplicationRecord

  # ActiveHash の設定
  belongs_to :key, class_name: 'Key', optional: true

  # バリデーション
  validates :list_title, presence: true
  validates :song_title, presence: true
  validates :user_id   , presence: true

  # アソシエーション
  belongs_to :user
  has_many   :comments , dependent: :destroy
  has_many   :favorites, dependent: :destroy
  has_many   :list_tags, dependent: :destroy
  has_many   :tags     , through: :list_tags


end
