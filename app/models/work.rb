class Work < ActiveRecord::Base
extend FriendlyId

  # Associations
  belongs_to :user
  has_many :comments, dependent: :delete_all
  has_many :histories, dependent: :delete_all
  has_many :favourites, dependent: :destroy

  # Strip leading and trailing whitespace from attributes
  auto_strip_attributes :title, :body

  # Tagging
  acts_as_taggable

  # Add friendly urls
  friendly_id :title, use: :slugged

  # Verifying minimum length of the title
  validates :title,
    uniqueness: { message: 'That title is already taken.' },
    presence: { message: 'Your work must have a title.' },
    length: { maximum: 255, too_long: 'Title can be a maximum %{count} characters.' }

  # Verifying that a body was provided
  validates :body,
    presence: { message: 'You cannot submit a blank work.' }

  # Verifying that search terms were provided
  validates :tag_list,
    presence: { message: 'You must provide at least one tag.' }

end
