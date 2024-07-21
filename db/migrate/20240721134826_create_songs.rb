class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.string     :song_title, null: false
      t.string     :reading
      t.integer    :key_id
      t.string     :singer
      t.string     :link
      t.string     :remarks
      t.references :list      , null: false, foreign_key: true
      t.timestamps
    end
  end

      # song_title  曲名
      # reading     読み仮名
      # key_id      キー(+-6)
      # singer      歌手名
      # link        リンク
      # remarks     備考

  def down
    drop_table :songs
  end


end
