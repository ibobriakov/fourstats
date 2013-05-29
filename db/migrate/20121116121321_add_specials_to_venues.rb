class AddSpecialsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :specials_message, :string
    add_column :venues, :specials_fineprint, :string
  end
end
