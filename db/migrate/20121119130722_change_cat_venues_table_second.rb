class ChangeCatVenuesTableSecond < ActiveRecord::Migration
  def change
    change_column :categories_venues, :updated_at, :datetime, :null => true
  end
end
