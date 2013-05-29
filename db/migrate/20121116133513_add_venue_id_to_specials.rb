class AddVenueIdToSpecials < ActiveRecord::Migration
  def change
    add_column :specials, :venue_id, :integer
  end
end
