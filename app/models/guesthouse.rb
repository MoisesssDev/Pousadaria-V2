class Guesthouse < ApplicationRecord
  belongs_to :owner
  has_many :rooms
  has_many :reservations
  validates :name, presence: true, length: { maximum: 255 }
  validates :legal_name, presence: true, length: { maximum: 255 }
  validates :cnpj, presence: true, uniqueness: true
  validates :phone, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :address, presence: true, length: { maximum: 255 }
  validates :district, presence: true, length: { maximum: 255 }
  validates :state, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 255 }
  validates :accepted_payment_methods, presence: true
  validates :check_in_time, presence: true
  validates :check_out_time, presence: true

  def self.recent(limit)
    order(created_at: :desc).limit(limit)
  end

  def self.active
    where(available: true)
  end

  def check_out_time_and_check_in_time_blank?
    errors.add(:check_out_time, "Check-in e Check-out não pode ficar em branco.") if check_in_time.blank? || check_out_time.blank?
  end
end
