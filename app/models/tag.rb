class Tag < ApplicationRecord

  validates :tag, presence: true, uniqueness: true


  has_many :list_tags, dependent: :destroy
  has_many :lists, through: :list_tags


end
