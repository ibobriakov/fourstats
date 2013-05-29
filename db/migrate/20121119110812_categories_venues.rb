class CategoriesVenues < ActiveRecord::Migration
  def change
    create_table :categories_venues do |t|
      t.integer :category_id
      t.integer :venue_id

      t.timestamps
    end
  end
end
