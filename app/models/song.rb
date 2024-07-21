# app/models/song.rb
class Song < ApplicationRecord

  # バリデーション
  validates :song_title, presence: true

  # アソシエーション
  belongs_to :list

end