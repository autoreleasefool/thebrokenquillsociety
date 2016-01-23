class About < ActiveRecord::Base

  # Strip leading and trailing whitespace from attributes
  auto_strip_attributes :title, :body, :link_title

  validates :title,
    presence: { message: 'You must provide a section title.' },
    length: { maximum: 255, too_long: 'A section title can only be a maximum %{count} characters.' }

  validates :body,
    presence: { message: 'You must provide a body.' },
    length: { maximum: 1000, too_long: 'The body can only be a maximum %{count} characters.' }

  validates :link_title,
    length: { maximum: 255, too_long: 'A link title can only be a maximum %{count} characters.' }

end
