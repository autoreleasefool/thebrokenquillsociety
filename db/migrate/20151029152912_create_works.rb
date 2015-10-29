class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.text :title
      t.text :body
      t.text :search_terms
      t.boolean :incomplete
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
