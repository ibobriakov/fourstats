class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.text :description
      t.decimal :rating, :precision => 2, :scale => 1
      t.integer :checkins_count
      t.integer :users_count
      t.integer :tips_count
      t.integer :photos_count

      t.timestamps
    end
  end
end
