class List < ApplicationRecord

  belongs_to :key, class_name: 'Key', optional: true

  validates :list_title, presence: true
  validates :song_title, presence: true
  validates :user_id   , presence: true

  belongs_to :user
  has_many   :comments , dependent: :destroy
  has_many   :favorites, dependent: :destroy
  has_many   :list_tags, dependent: :destroy
  has_many   :tags     , through: :list_tags

end
