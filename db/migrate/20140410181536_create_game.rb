class CreateGame < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.integer :winner_id, :references => Player
      t.integer :moves_count, :default => 0
      t.boolean :over, :default => false
      t.timestamps
    end
  end

  def down
    drop_table :games
  end
end
