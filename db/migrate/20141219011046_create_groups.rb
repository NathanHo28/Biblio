class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :story_id
      t.integer :user_id

      t.timestamps
    end
  end
end
