class AddIdCatFoursqToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :id_foursquare_category, :string
  end
end
