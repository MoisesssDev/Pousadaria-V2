class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.date :entry_date
      t.date :departure_date
      t.integer :number_of_guests
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
