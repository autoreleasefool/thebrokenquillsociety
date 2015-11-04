class Comment < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :work

  # Verifying that a body was provided for the comment
  validates :body,
    presence: { message: 'You cannot submit a blank comment.' }

end
