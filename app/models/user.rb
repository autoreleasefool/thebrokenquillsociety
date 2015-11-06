class User < ActiveRecord::Base

  # Enabling password encryption
  has_secure_password

  # Associations
  has_many :works, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_many :announcements, dependent: :nullify

  # Tagging
  acts_as_taggable

  # Verifying valid username
  validates :name,
    presence: true,
    uniqueness: true,
    length: { in: 2..50 },
    format: { with: /\A[a-z0-9-]+\z/i, message: 'Username can only contain numbers, letters, and hyphens.' }

  # Verifying valid email
  validates :email,
    presence: true,
    uniqueness: true,
    length: { in: 12..50},
    format: { with: /\A([^@\s]+)@uottawa[.]ca\z/i, message: 'You must use an @uOttawa.ca email.' }

  # Verifying minimum password length
  validates :password,
    presence: true,
    length: { minimum: 6, message: 'Password must be minimum %{count} characters.' }

  # Verifying maximum length of about section
  validates :about,
    presence: true,
    length: { maximum: 1000, message: 'About can be a maximum %{count} characters.' }

end
