class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|


      t.references :user , null: false, foreign_key: true
      t.references :list , null: false, foreign_key: true

      # user  お気に入りしたユーザー
      # list  お気に入りされたリスト

      t.timestamps
    end
  end
end
