class CreateMoves < ActiveRecord::Migration
  def up
    create_table :moves do |t|
      t.string :from, :limit => 2
      t.string :to, :limit => 2
      t.integer :game_player_id, :references => GamePlayer
      t.boolean :legal
      t.datetime :validation_time
      t.timestamps
    end
  end

  def down
    drop_table :moves
  end
end
