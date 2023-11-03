class AddGuesthouseReferenceToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :guesthouse, foreign_key: true
  end
end
