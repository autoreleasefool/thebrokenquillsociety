class Comment < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :work

  # Strip leading and trailing whitespace from attributes
  auto_strip_attributes :body

  # Verifying that a body was provided for the comment
  validates :body,
    presence: { message: 'You cannot submit a blank comment.' },
    length: { maximum: 1000, too_long: 'Comment can be a maximum %{count} characters.' }

end
