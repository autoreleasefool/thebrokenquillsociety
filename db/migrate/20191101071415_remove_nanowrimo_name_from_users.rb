class RemoveNanowrimoNameFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :nanowrimo_name, :text
  end
end
