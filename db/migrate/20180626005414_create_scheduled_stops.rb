class CreateScheduledStops < ActiveRecord::Migration[5.2]
  def change
    create_table :scheduled_stops do |t|
      t.string "game_id", :default => 'notNull', :null => false
      t.datetime "shutdown_time", :null => false
      t.datetime "warning_sent_at"
      t.datetime "completed_at"
      t.datetime "canceled_at"
      t.timestamps
    end
  end
end
