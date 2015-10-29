class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true, uniqueness: true, :length => {
    :minimum => 2,
    :maximum => 50}

end
