class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :custom_prices

  def mark_as_available
    update(available: true)
  end

  def mark_as_unavailable
    update(available: false)
  end
end
