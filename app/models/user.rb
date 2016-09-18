class User < ActiveRecord::Base
extend FriendlyId

  attr_accessor :remember_token, :activation_token, :reset_token

  # Allows GET requests
  require 'net/http'

  # Strip leading and trailing whitespace from attributes
  auto_strip_attributes :name, :email, :about, :admin_description

  # Enabling password encryption
  has_secure_password

  # Save emails in lowercase
  before_save { self.email = email.downcase }

  # Associations
  has_many :works, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_many :histories, dependent: :nullify
  has_many :announcements, dependent: :nullify
  has_many :favourites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :admin_options, dependent: :destroy

  # Enable following users
  has_and_belongs_to_many(:follows,
    :join_table => "user_follows",
    :foreign_key => "user_a_id",
    :association_foreign_key => "user_b_id",
    :class_name => "User")

  # Tagging
  acts_as_taggable

  # Add friendly urls
  friendly_id :name, use: :slugged

  # Checks for valid nanowrimo name
  validate :check_nanowrimo_name

  # Verifying valid username
  validates :name,
    presence: true,
    uniqueness: { message: 'That username is already taken.' },
    length: { in: 2..32, too_short: 'Username must be a minimum %{count} characters.', too_long: 'Username can be a maximum %{count} characters.' },
    format: { with: /\A[a-z0-9-]+\z/i, message: 'Username can only contain numbers, letters, and hyphens.' }

  # Verifying valid email
  validates :email,
    presence: true,
    uniqueness: { message: 'That email has already been used.' },
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

  # Verifying maximum length of admin description section
  validates :admin_description,
    length: { maximum: 500, message: 'Admin description can be a maximum %{count} characters.' }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # If a nanowrimo username was provided, checks to make sure it returns a valid account
  def check_nanowrimo_name
    self.nanowrimo_name.strip!
    if self.nanowrimo_name && self.nanowrimo_name.length > 0
      nano_check = self.nanowrimo_name.gsub(/\s/,'-')
      nano_check.gsub!(/\./,'')
      url = URI.parse('http://nanowrimo.org/wordcount_api/wc/' + self.nanowrimo_name)
      request = Net::HTTP::Get.new(url)
      response = Net::HTTP.start(url.host, url.port){ |http| http.request(request) }
      if response.body.include? 'user does not exist'
        errors.add(:nanowrimo_name, 'This is not a valid NaNoWriMo username.')
      end
    end
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

end
