class Favourite < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :work

end
