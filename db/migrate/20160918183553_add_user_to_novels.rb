class AddUserToNovels < ActiveRecord::Migration[5.0]
  def change
    add_reference :novels, :user, foreign_key: true
  end
end
