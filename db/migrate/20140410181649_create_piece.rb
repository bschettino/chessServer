class CreatePiece < ActiveRecord::Migration
  def up
    create_table :pieces do |t|
      t.integer :kind
      t.boolean :alive, :default => true
      t.integer :game_id, :references => Game
      t.integer :player_id, :references => Player
      t.timestamps
    end
  end

  def down
    drop_table :pieces
  end
end
