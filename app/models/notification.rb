class Notification < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :notifier, :class_name => 'User', :foreign_key => 'notifier'

end
