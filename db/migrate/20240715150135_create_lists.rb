class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|


      t.string     :list_title  , null: false
      t.text       :description
      t.string     :song_title  , null: false
      t.string     :reading
      t.integer    :key_id
      t.string     :singer
      t.string     :link
      t.string     :remarks
      t.references :user        , null: false, foreign_key: true
      t.boolean    :public      , null: false, default: false

      # list_title   リスト名
      # description  リストの説明
      # song_title    曲名
      # reading       読み仮名
      # key_id        キー(+-6)
      # singer        歌手名
      # link          リンク
      # remarks       備考
      # user          作成者のユーザーID
      # public        リストの公開/非公開設定


      t.timestamps
    end
  end
end
