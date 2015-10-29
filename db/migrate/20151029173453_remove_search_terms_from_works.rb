class RemoveSearchTermsFromWorks < ActiveRecord::Migration
  def change
    remove_column :works, :search_terms, :text
  end
end
