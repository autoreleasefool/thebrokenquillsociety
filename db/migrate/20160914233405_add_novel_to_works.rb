class AddNovelToWorks < ActiveRecord::Migration[5.0]
  def change
    add_reference :works, :novel, foreign_key: true
  end
end
