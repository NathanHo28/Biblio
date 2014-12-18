class AddCityToStories < ActiveRecord::Migration
  def change
    add_column :stories, :city, :string, :null => false
  end
end
