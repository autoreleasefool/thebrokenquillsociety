class Announcement < ActiveRecord::Base

  # Associations
  belongs_to :user

  # Verifying title exists
  validates :title,
    presence: { message: 'Your announcement must have a title.' },
    length: { maximum: 255, too_long: 'Title can be a maximum %{count} characters.' }

  # Verifying announcement exists
  validates :body,
    presence: { message: 'You cannot submit a blank announcement.' },
    length: { maximum: 200, too_long: 'Body can be a maximum %{count} characters.' }

end
