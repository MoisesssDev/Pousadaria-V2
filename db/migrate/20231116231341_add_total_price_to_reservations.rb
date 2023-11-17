class AddTotalPriceToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :total_price, :decimal
  end
end
