class CreateSpecials < ActiveRecord::Migration
  def change
    create_table :specials do |t|
      t.string :message
      t.string :finetext

      t.timestamps
    end
  end
end
