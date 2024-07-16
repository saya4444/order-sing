class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|


      t.text       :content , null: false
      t.references :user    , null: false, foreign_key: true
      t.references :list    , null: false, foreign_key: true

      # content  コメントの内容
      # user     コメントしたユーザー
      # list     コメントされたリスト


      t.timestamps
    end
  end
end
