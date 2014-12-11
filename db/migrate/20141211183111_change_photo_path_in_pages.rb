class ChangePhotoPathInPages < ActiveRecord::Migration
  def change
  	rename_column :pages, :photo_path, :page_photo
  end
end
