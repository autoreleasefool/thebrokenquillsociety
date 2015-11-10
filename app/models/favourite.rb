class Favourite < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :work

  # Checks if user has already favourited the work once.
  validate :user_has_not_favourited_work

  # Check if the user has already favourited the work before and throw an error if so
  def user_has_not_favourited_work
    errors.add('You cannot favourite a work twice.') unless Favourite.find_by(user_id: self.user_id, work_id: self.work_id).nil?
  end

end
