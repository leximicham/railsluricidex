class CreateServers < ActiveRecord::Migration[5.2]
  def change
    create_table :servers do |t|
      t.string "friendly_name"
      t.string "ip", :limit => 15, :null => false
      t.string "username", :null => false
      t.text "keyfile", :null => false
      t.timestamps
    end
  end
end
