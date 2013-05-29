class AddFsIdToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :id_foursquare, :string
  end
end
