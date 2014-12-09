class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name,       :null => false
      t.string :last_name,        :null => false
      t.string :username,         :null => false
      t.string :photo,            :null => false
      t.string :about_me,         :null => false
      t.string :home_town,        :null => false
      t.string :email,            :null => false
      t.string :crypted_password, :null => false
      t.string :salt,             :null => false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end