class Reservation < ApplicationRecord
  belongs_to :room

  validates_presence_of :entry_date, :departure_date, :number_of_guests
  validate :validate_dates

  private

  def validate_dates
    if entry_date && departure_date && entry_date >= departure_date
      errors.add(:base, 'A data de entrada deve ser anterior à data de saída.')
    end
  end
end
