class AddUnreadNotificationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unread_notifications, :integer
  end
end
