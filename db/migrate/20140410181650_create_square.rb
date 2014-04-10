class CreateSquare < ActiveRecord::Migration
  def up
    create_table :squares do |t|
      t.integer :line
      t.string :column, :limit => 1
      t.integer :game_id, :references => Game
      t.integer :piece_id, :references => Piece
      t.timestamps
    end
  end

  def down
    drop_table :squares
  end
end
