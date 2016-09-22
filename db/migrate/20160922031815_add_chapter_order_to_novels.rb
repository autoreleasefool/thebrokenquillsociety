class AddChapterOrderToNovels < ActiveRecord::Migration[5.0]
  def change
    add_column :novels, :chapter_order, :string
  end
end
