class AddPageNumberToPages < ActiveRecord::Migration
  def change
    add_column :pages, :page_number, :int
  end
end
