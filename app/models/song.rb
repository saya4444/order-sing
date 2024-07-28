# app/models/song.rb
class Song < ApplicationRecord

  # ActiveHashの設定
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :key

  # アソシエーション
  belongs_to :list

end