class RemoveGuesthouseIdFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :guesthouse_id
  end
end
