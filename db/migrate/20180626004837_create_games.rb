class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string "server_id", :null => false
      t.string "friendly_name"
      t.string "service_name", :null => false
      t.timestamps
    end
  end
end
