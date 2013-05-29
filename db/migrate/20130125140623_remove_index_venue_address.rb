class RemoveIndexVenueAddress < ActiveRecord::Migration
  def change
    remove_index :venues, [:name, :address]
  end
end
