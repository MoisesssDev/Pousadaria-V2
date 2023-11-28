class Reservation < ApplicationRecord
  before_create :generate_reservation_code

  belongs_to :room
  belongs_to :guesthouse, optional: true
  belongs_to :client, optional: true

  validate :valid_dates

  enum status: { confirmed: 'confirmada', canceled: 'cancelada' }

  after_create :set_status_confirmed

  def cancellable?
    return false if status == 'canceled'

    # Verifica se a data de check-in está pelo menos a 7 dias de distância
    (entry_date - 7.days).future?
  end

  def valid_dates
    if entry_date.blank? || departure_date.blank?
      errors.add(:base, "Datas de entrada e saída são obrigatórias.")
      return
    end

    if entry_date > departure_date
      errors.add(:base, "A data de entrada não pode ser posterior à data de saída.")
    end

    if entry_date < Date.today
      errors.add(:base, "A data de entrada não pode ser anterior à data atual.")
    end
  end

  private

  def generate_reservation_code
    loop do
      # Gera um código de reserva aleatório de 8 caracteres
      self.code = SecureRandom.hex(4).upcase[0, 8]

      # Verifica se o código já existe em outras reservas
      break unless Reservation.exists?(code: self.code)
    end
  end

  def set_status_confirmed
    update(status: :confirmed)
  end
end
