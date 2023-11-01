class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  TYPE_OWNER = 'dono_pousada'
  TYPE_CUSTOMER = 'hospede'

  def owner?
    role == TYPE_OWNER
  end

  def customer?
    role == TYPE_CUSTOMER
  end
end
