# app/models/song.rb
class Song < ApplicationRecord

  # ActiveHashの設定
  def key
    Key.find_by(id: key_id)
  end

  belongs_to :list

end