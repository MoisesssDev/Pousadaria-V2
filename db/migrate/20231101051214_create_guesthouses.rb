class CreateGuesthouses < ActiveRecord::Migration[7.1]
  def change
    create_table :guesthouses do |t|
      t.string :name
      t.string :legal_name
      t.string :cnpj
      t.string :phone
      t.string :email
      t.string :address
      t.string :district
      t.string :state
      t.string :city
      t.string :cep
      t.text :description
      t.string :accepted_payment_methods
      t.boolean :accepts_pets
      t.text :policies
      t.time :check_in_time
      t.time :check_out_time

      t.timestamps
    end
  end
end
