class AddPortToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :port, :integer
  end
end
