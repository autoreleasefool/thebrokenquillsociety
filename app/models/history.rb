class History < ActiveRecord::Base

  # Associations
  belongs_to :work
  belongs_to :user

end
