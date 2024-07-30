class RemoveSongFieldsFromLists < ActiveRecord::Migration[7.0]
  def change
    remove_column :lists, :song_title, :string
    remove_column :lists, :reading, :string
    remove_column :lists, :key_id, :integer
    remove_column :lists, :singer, :string
    remove_column :lists, :link, :string
    remove_column :lists, :remarks, :string
  end
end
