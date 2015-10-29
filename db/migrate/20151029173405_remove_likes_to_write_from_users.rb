class RemoveLikesToWriteFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :likes_to_write, :text
  end
end
