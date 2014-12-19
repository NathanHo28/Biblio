class ModifyLatitudeAndLongitudeStories < ActiveRecord::Migration
  def down
  	remove_column :stories, :latitude
    remove_column :stories, :longitude

    add_column :stories, :latitude, :decimal, :default => 0, :null => false
    add_column :stories, :longitude, :decimal, :default => 0, :null => false
  end
  def up
    remove_column :stories, :latitude
    remove_column :stories, :longitude

    add_column :stories, :latitude, :decimal
    add_column :stories, :longitude, :decimal
  end
end
