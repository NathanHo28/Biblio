class RemoveHomeCountryFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :home_country, :string
  end
end
