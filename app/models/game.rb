class Game < ApplicationRecord

  belongs_to :server
  has_many :scheduled_stops

end
