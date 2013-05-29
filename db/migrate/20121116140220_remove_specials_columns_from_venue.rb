class RemoveSpecialsColumnsFromVenue < ActiveRecord::Migration
  def change
    remove_column :venues, :specials_message
    remove_column :venues, :specials_fineprint
  end
end
