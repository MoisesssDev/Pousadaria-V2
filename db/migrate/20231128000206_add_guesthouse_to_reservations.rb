class AddGuesthouseToReservations < ActiveRecord::Migration[7.1]
  def change
    add_reference :reservations, :guesthouse, null: false, foreign_key: true
  end
end
