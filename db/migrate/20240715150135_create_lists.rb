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
      t.references :user_id     , null: false, foreign_key: true
      t.boolean    :public      , null: false, default: false


      t.timestamps
    end
  end
end
