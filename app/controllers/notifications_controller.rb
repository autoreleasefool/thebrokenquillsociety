class NotificationsController < ApplicationController

  # User must be logged in to perform any actions with notifications
  before_action :logged_in_user

  # Shows the notifications of a user
  def show
    # Title of the webpage
    @title = 'Notifications'

    # Getting all of the user's notifications, then those that are unread
    @all_notifications = Notification.where(["user_id = :id", { id: current_user.id }]).order(created_at: :desc)
    @notification_content = {}
    @unread_notification_ids = []

    @all_notifications.each do |notification|
      puts "id: " + notification.id.to_s
      if notification.unread?
        puts "unread: " + notification.id.to_s
        # Mark all of the unread notifications as read, since they have now been opened
        @unread_notification_ids << notification.id
        notification.unread = false
        notification.save
      end

      # Get the pieces of the body of the notification
      if notification.body
        @notification_content[notification.id] = notification.body.split(/\n/)
      end

    end

    # Clear the number of unread notifications for the user
    current_user.update_attribute(:unread_notifications, 0)
  end

end
