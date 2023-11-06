class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.integer :dimension
      t.integer :max_occupancy
      t.decimal :daily_rate
      t.boolean :has_private_bathroom
      t.boolean :has_balcony
      t.boolean :has_air_conditioning
      t.boolean :has_tv
      t.boolean :has_wardrobe
      t.boolean :is_accessible
      t.boolean :has_cofre
      t.boolean :available
      t.references :guesthouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
