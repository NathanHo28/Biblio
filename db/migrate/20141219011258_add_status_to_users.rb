class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :state, :integer
  end
end
