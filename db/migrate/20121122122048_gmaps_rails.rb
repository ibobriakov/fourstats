class GmapsRails < ActiveRecord::Migration
  def change
    add_column :venues, :latitude,  :float #you can change the name, see wiki
    add_column :venues, :longitude, :float #you can change the name, see wiki
    add_column :venues, :gmaps, :boolean #not mandatory, see wiki
  end
end
