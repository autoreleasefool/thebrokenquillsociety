class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :work, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
