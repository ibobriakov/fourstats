class ChangeCatVenuesTable < ActiveRecord::Migration
  def change
    change_column :categories_venues, :created_at, :datetime, :null => true
  end
end
