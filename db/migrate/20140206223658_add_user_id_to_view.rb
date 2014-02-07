class AddUserIdToView < ActiveRecord::Migration
  def change
    add_column :views, :user_id, :integer
  end
end
