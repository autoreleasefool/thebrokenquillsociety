class AddIsAnonymousToWorks < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :is_anonymous, :boolean
  end
end
