class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.attachment :upload
      t.references :user

      t.timestamps null: false
    end
  end
end
