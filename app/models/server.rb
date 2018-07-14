class Server < ApplicationRecord
  # id
  # friendly_name
  # ip
  # username
  # keyfile
require_dependency 'runit'

  has_many :games

  def connect
      @conn ||=Runit.new(ip: self.ip, username: self.username, keyfile: self.keyfile)
      @conn
end

  def game_stats
    stats = {}
    stats[:num_running] = self.games.select { |g| g.running? }.size
    stats[:num_stopped] = self.games.select { |g| !g.running? }.size
    stats
  end
