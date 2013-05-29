class AddUniquenessToJoinsTable < ActiveRecord::Migration
  def change
    add_index :categories_venues, [ :category_id, :venue_id ], :unique => true, :name => 'by_category_and_venue'
  end
end
