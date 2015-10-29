class Work < ActiveRecord::Base

  # Associations
  belongs_to :user

  # Verifying minimum length of the title
  validates :title,
    presence: true,
    length: { maximum: 255, too_long: 'maximum %{count} characters'}

  # Verifying that a body was provided
  validates :body,
    presence: true

  # Verifying that search terms were provided
  validates :search_terms,
    presence: true

end
