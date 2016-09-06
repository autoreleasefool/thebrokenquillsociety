class AddIsPrivateToWorks < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :is_private, :boolean
  end
end
