class AddLongituteToStories < ActiveRecord::Migration
  def change
    add_column :stories, :longitude, :decimal
  end
end
