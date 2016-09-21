class AddNovelPositionToWorks < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :novel_position, :int
  end
end
