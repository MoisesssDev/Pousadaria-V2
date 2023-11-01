class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :guesthouse
  validates :email, :encrypted_password, presence: true
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
