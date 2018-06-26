class AddIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index("games", "server_id")
    add_index("scheduled_stops", "game_id")
    add_index("scheduled_stops", "warning_sent_at")
  end
end
