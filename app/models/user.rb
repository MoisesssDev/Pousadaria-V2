class User < ApplicationRecord
  has_one :guesthouse
  validates :email, :password, presence: true
  validates :email, uniqueness: true

  TYPE_OWNER = 'dono_pousada'
  TYPE_CUSTOMER = 'hospede'

  def owner?
    role == TYPE_OWNER
  end

  def customer?
    role == TYPE_CUSTOMER
  end
end
