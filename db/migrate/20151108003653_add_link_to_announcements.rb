class AddLinkToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :link, :text
  end
end
