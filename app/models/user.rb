class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :guesthouse

  TYPE_OWNER = 'dono_pousada'
  TYPE_CUSTOMER = 'hospede'

  def find_guesthouse_id
    guesthouse_id = guesthouse.id
  end

  def owner?
    role == TYPE_OWNER
  end

  def customer?
    role == TYPE_CUSTOMER
  end
end
