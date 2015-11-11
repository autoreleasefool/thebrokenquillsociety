class FixAside < ActiveRecord::Migration
  def change
    rename_column :abouts, :aside, :link_title
  end
end
