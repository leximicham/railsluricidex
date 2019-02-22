class AddNotesToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :notes, :string
  end
end
