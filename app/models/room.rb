class Room < ApplicationRecord
  belongs_to :guesthouse

  def mark_as_available
    update(available: true)
  end

  def mark_as_unavailable
    update(available: false)
  end
end
