class AddLatitudeToStories < ActiveRecord::Migration
  def change
    add_column :stories, :latitude, :decimal
  end
end
