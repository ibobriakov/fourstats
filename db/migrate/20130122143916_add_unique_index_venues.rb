class AddUniqueIndexVenues < ActiveRecord::Migration
  def change
    add_index  :venues, [:name, :address], :unique => false
  end
end
