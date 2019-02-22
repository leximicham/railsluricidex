class Game < ApplicationRecord
  # id
  # server_id
  # friendly_name
  # service_name

  belongs_to :server
  has_many :scheduled_stops

  def get_status
    @status ||= self.server.connect.status(self.service_name)
    @status
  end

  def running?
    get_status.running?
  end

  def uptime
    get_status.uptime
  end

  def call_start
	self.server.connect.start(self.service_name)
  end

  def call_stop
	self.server.connect.stop(self.service_name)
  end
end
