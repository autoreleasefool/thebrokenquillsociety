class CreateAdminOptions < ActiveRecord::Migration
  def change
    create_table :admin_options do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :options_enabled

      t.timestamps null: false
    end
  end
end
