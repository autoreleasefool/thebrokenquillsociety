class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :title
      t.text :body
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
