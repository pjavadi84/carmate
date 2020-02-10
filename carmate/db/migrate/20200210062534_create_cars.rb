class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.string :color
      t.string :car_type
      t.integer :price

      t.integer :user_id
      t.timestamps null: false
    end
  end
end
