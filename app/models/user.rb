class User < ActiveRecord::Base

  # Enabling password encryption
  has_secure_password

  # Save emails in lowercase
  before_save { self.email = email.downcase }

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
    length: { in: 2..32, too_short: 'Username must be a minimum %{count} characters.', too_long: 'Username can be a maximum %{count} characters.' },
    format: { with: /\A[a-z0-9-]+\z/i, message: 'Username can only contain numbers, letters, and hyphens.' }

  # Verifying valid email
  validates :email,
    presence: true,
    uniqueness: true,
    length: { in: 12..50},
    format: { with: /\A([^@\s]+)@uottawa[.]ca\z/i, message: 'You must use an @uOttawa.ca email.' }

  # Verifying minimum password length
  validates :password,
    on: :create,
    presence: true,
    length: { minimum: 6, message: 'Password must be a minimum %{count} characters.' }

  # Verifying password confirmation matches
  validates :password_confirmation,
    on: :create,
    presence: { message: 'This field must match your password.' }

  # Verifying maximum length of about section
  validates :about,
    presence: true,
    length: { maximum: 1000, message: 'About can be a maximum %{count} characters.' }

end
