class CreateStoryContributors < ActiveRecord::Migration
  def change
    create_table :story_contributors do |t|
      t.references :story, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
