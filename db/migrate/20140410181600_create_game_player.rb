class CreateGamePlayer < ActiveRecord::Migration
  def up
    create_table :game_players do |t|
      t.integer :player_id, :references => Player
      t.integer :game_id, :references => Game
      t.integer :checks_count
      t.timestamps
    end
  end

  def down
  end
end
