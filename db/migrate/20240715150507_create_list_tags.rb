class CreateListTags < ActiveRecord::Migration[7.0]
  def change
    create_table :list_tags do |t|

      t.timestamps
    end
  end
end
