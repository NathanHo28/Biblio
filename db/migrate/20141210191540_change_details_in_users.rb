class ChangeDetailsInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :photo, :string, :default => '', :null => false 
  	change_column :users, :about_me, :string, :default => '', :null => false
  	change_column :users, :home_town, :string, :default => '', :null => false
  end
end
