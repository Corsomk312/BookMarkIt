class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :name, null: false
      t.text :url, null: false

      t.timestamps null: false
    end
  end
end
