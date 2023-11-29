class AddCheckoutDetailsToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :checkout_date, :datetime
    add_column :reservations, :payment_method, :string
  end
end
