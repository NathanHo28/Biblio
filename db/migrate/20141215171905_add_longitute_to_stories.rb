class AddLongituteToStories < ActiveRecord::Migration
  def change
    add_column :stories, :longitude, :decimal, :default => 0
  end
end
