class AddLongitudeToStories < ActiveRecord::Migration
  def change
    add_column :stories, :longitude, :decimal, :default => 0, :null => false
  end
end
