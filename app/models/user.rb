class User < ActiveRecord::Base

  has_secure_password

  # Verifying valid username
  validates :name,
    presence: true,
    uniqueness: true,
    length: { in: 2..50 },
    format: { with: /\A[a-z0-9-]+\z/i, message: 'only numbers, letters and hyphens allowed' }

  # Verifying valid email
  validates :email,
    presence: true,
    uniqueness: true,
    length: { in: 12..50},
    format: { with: /\A([^@\s]+)@uottawa[.]ca\z/i, message: 'must be an @uottawa.ca email' }

  # Verifying minimum password length
  validates :password,
    presence: true,
    length: { minimum: 6, too_short: 'passwords must be minimum %{count} characters'}

  # Verifying maximum length of about section
  validates :about,
    presence: true,
    length: { maximum: 500, too_long: 'maximum %{count} characters' }

end
