class AddAdminDescriptionToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin_description, :text
  end
end
