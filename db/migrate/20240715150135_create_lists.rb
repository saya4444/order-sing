class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|


      t.string     :list_title  , null: false
      t.text       :description
      t.references :user        , null: false, foreign_key: true
      t.boolean    :public      , null: false, default: false

      # list_title   リスト名
      # description  リストの説明
      # user         作成者のユーザーID
      # public       リストの公開/非公開設定


      t.timestamps
    end
  end
end
