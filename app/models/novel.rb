class Novel < ApplicationRecord
extend FriendlyId

  # Associations
  belongs_to :user
  has_many :works

  # Strip leading and trailing whitespace from attributes
  auto_strip_attributes :title, :description

  # Tagging
  acts_as_taggable

  # Add friendly urls
  friendly_id :title, use: :slugged

  # Verifying minimum length of the title
  validates :title,
    uniqueness: { message: 'That title is already taken.' },
    presence: { message: 'Your novel must have a title.' },
    length: { maximum: 255, too_long: 'Title can be a maximum %{count} characters.' }

  # Verifying that search terms were provided
  validates :tag_list,
    presence: { message: 'You must provide at least one tag.' }
end
