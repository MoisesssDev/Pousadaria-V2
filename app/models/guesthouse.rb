class Guesthouse < ApplicationRecord
  belongs_to :user
  has_many :rooms

  def self.recent(limit)
    order(created_at: :desc).limit(limit)
  end

  def self.active
    where(available: true)
  end
end
