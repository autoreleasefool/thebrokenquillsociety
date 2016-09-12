class CreateUserFollowsTable < ActiveRecord::Migration[5.0]
  def change
    create_table "user_follows", :force => true, :id => false do |t|
      t.integer "user_a_id", :null => false
      t.integer "user_b_id", :null => false
    end
  end
end
