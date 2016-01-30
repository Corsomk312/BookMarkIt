class CreateSavedBookmarks < ActiveRecord::Migration
  def change
    create_table :saved_bookmarks do |t|
      t.integer :list_id, null: false
      t.integer :bookmark_id, null: false

      t.timestamps null: false
    end
  end
end
