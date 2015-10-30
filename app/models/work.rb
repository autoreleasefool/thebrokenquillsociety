class Work < ActiveRecord::Base

  # Associations
  belongs_to :user
  has_many :comments, dependent: :delete_all

  # Tagging
  acts_as_taggable

  # Verifying minimum length of the title
  validates :title,
    presence: true,
    length: { maximum: 255, too_long: 'maximum %{count} characters'}

  # Verifying that a body was provided
  validates :body,
    presence: true

end
