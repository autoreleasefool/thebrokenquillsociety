class AddUserToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :notifier, :integer
    add_index :notifications, :notifier
  end
end
