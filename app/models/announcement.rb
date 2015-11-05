class Announcement < ActiveRecord::Base

  # Associations
  belongs_to :user

  # Verifying title exists
  validates :title,
    presence: { message: 'Your announcement must have a title.' },
    length: { maximum: 255, too_long: 'Your title must be less than %{count} characters.'}

  # Verifying announcement exists
  validates :body,
    presence: { message: 'You cannot submit a blank announcement.' },
    length: { maximum: 200, 'An announcement can be a maximum of %{count} characters.'}

end
