class CreateServers < ActiveRecord::Migration[5.2]
  def change
    create_table :servers do |t|
      t.string "friendly_name"
      t.string "ip", :limit => 15, :default => 'notNull', :null => false
      t.string "username", :default => 'notNull', :null => false
      t.text "keyfile", :default => 'notNull', :null => false
      t.timestamps
    end
  end
end
