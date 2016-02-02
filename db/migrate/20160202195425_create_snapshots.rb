class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.attachment :thumbnail
      t.integer :bookmark_id
      t.timestamps null: false
    end
  end
end
