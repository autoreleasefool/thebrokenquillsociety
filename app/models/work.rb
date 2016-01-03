class Work < ActiveRecord::Base
extend FriendlyId

  # Associations
  belongs_to :user
  has_many :comments, dependent: :delete_all
  has_many :favourites, dependent: :destroy

  # Tagging
  acts_as_taggable

	# Add friendly urls
	friendly_id :title, use: :slugged

  # Verifying minimum length of the title
  validates :title,
    presence: { message: 'Your work must have a title.' },
    length: { maximum: 255, too_long: 'Title can be a maximum %{count} characters.' }

  # Verifying that a body was provided
  validates :body,
    presence: { message: 'You cannot submit a blank work.' }

  # Verifying that search terms were provided
  validates :tag_list,
    presence: { message: 'You must provide at least one tag.' }

end
