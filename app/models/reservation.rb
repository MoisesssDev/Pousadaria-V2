class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :client, optional: true
  validate :valid_dates

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
end
