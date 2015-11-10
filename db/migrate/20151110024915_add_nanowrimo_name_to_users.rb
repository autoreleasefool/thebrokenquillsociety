class AddNanowrimoNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nanowrimo_name, :text
  end
end
