class CreateListTags < ActiveRecord::Migration[7.0]
  def change
    create_table :list_tags do |t|



      t.references :list , null: false, foreign_key: true
      t.references :tag  , null: false, foreign_key: true

      # list  タグ付けされたリスト
      # tag   付けられたタグ



      t.timestamps
    end
  end
end
