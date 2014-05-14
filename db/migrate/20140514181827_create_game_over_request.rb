class CreateGameOverRequest < ActiveRecord::Migration
  def up
    create_table :game_over_requests do |t|
      t.integer :game_id, :references => Game
      t.integer :winner_id, :references => Player
      t.integer :requestor_id, :references => GamePlayer
      t.boolean :legal
      t.datetime :validation_time
      t.timestamps
    end
  end

  def down
    drop_table :game_over_requests
  end
end
