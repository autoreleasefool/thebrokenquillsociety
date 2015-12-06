class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :body
      t.integer :type
      t.text :link
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
