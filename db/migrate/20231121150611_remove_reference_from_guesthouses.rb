class RemoveReferenceFromGuesthouses < ActiveRecord::Migration[7.1]
  def change
    remove_reference :guesthouses, :user, null: false, foreign_key: true
  end
end
