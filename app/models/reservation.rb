class Reservation < ApplicationRecord
  before_create :generate_reservation_code

  belongs_to :room
  belongs_to :guesthouse, optional: true
  belongs_to :client, optional: true

  validate :valid_dates

  enum status: { confirmed: 'confirmada', canceled: 'cancelada', active: 'ativa', finalized: 'finalizada' }
  scope :active_stays, -> { where(status: :active) }

  after_create :set_status_confirmed

  def cancellable?
    return false if status == 'canceled'

    entry_date >= 7.days.from_now || entry_date <= 2.days.ago
  end

  def valid_dates
    if entry_date.blank? || departure_date.blank?
      errors.add(:base, "Datas de entrada e saída são obrigatórias.")
      return
    end

    if entry_date > departure_date
      errors.add(:base, "A data de entrada não pode ser posterior à data de saída.")
    end
  end

  def check_in
    if entry_date <= Time.now
      update(status: :active, check_in_date: Time.now)
    else
      errors.add(:base, 'Check-in disponível apenas a partir da data de entrada.')
      false
    end
  end

  def checkout(total_paid, payment_method)
    update(
      status: :finalized,
      checkout_date: Time.now,
      total_price: total_paid,
      payment_method: payment_method
    )
  end

  private

  def generate_reservation_code
    loop do
      self.code = SecureRandom.hex(4).upcase[0, 8]

      break unless Reservation.exists?(code: self.code)
    end
  end

  def set_status_confirmed
    update(status: :confirmed)
  end
end
