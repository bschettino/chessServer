class CreateGame < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.integer :winner_id, :references => Player
      t.timestamps
    end
  end

  def down
    drop_table :games
  end
end
