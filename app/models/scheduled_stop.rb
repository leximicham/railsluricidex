class ScheduledStop < ApplicationRecord
  # game_id
  # created_at
  # updated_at
  # shutdown_time
  # warning_sent_at
  # completed_at
  # cancelled_at

  belongs_to :game

  loop.do
    ScheduledStop.where(shutdown_time < (Time.now + 30.minutes) && warning_sent.nil?).each do |warning|
      # send warnings
      warning.warning_sent_at = Time.now
      warning.save!
    end
    ScheduledStop.where(warning_sent < (Time.now - 30.minutes) && completed.nil?).each do |shutdown|
      shutdown.game.server.connection.stop
      shutdown.completed_at = Time.now
      shutdown.save!
    end

    sleep 60
end
