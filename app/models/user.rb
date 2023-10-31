class User < ApplicationRecord
  validates :email, :password, presence: true
  validates :email, uniqueness: true

  TYPE_OWNER = 'dono_pousada'
  TYPE_CLIENT = 'hospede'

  def owner?
    tipo == TYPE_OWNER
  end

  def client?
    tipo == TYPE_CLIENT
  end
end
