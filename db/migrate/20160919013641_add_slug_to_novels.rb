class AddSlugToNovels < ActiveRecord::Migration[5.0]
  def change
    add_column :novels, :slug, :string
  end
end
