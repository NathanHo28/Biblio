class AddHomeCountryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_country, :string
  end
end
