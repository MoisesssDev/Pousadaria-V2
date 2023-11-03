class RemoveForeignKeyFromUsers < ActiveRecord::Migration[7.1]
  class RemoveForeignKeyFromUsers < ActiveRecord::Migration[7.1]
    def up
      remove_foreign_key :users, :guesthouses  # Remove a chave estrangeira
    end
  
    def change
      # Define os valores adequados para a coluna guesthouse_id, por exemplo, todos como NULL
      User.update_all(guesthouse_id: nil)
    end
  
    def down
      # Adicione novamente a chave estrangeira (em caso de rollback)
      add_foreign_key :users, :guesthouses, column: :guesthouse_id
    end
  end
  
end
