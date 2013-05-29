class RenameDescriptionToAddress < ActiveRecord::Migration
  def change
    rename_column :venues, :description, :address
  end
end
