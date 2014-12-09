class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :photo_path
      t.string :caption
      t.integer :story_id
      t.timestamps
    end
  end
end
