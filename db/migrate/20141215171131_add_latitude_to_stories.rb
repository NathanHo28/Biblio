class AddLatitudeToStories < ActiveRecord::Migration
  def change
    add_column :stories, :latitude, :decimal, :default => 0, :null => false
  end
end
