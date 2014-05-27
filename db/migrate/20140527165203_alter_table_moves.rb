class AlterTableMoves < ActiveRecord::Migration
  def up
    add_column :moves, :move_type, :integer
    add_column :moves, :eliminated_pawn, :string, :limit => 2
    add_column :moves, :promotion_type, :integer
    Move.all.each do |m|
      Movimentation.create(:move_id => m.id, :to => m.to, :from => m.from)
      m.update_attributes(:move_type => Move::TYPE_NORMAL)
    end
    remove_column :moves, :from
    remove_column :moves, :to
  end

  def down
    add_column :moves, :from, :string, :limit => 2
    add_column :moves, :to, :string, :limit => 2
    Movimentation.all.each do |m|
      m.move.update_attributes(:from => m.from, :to => m.to)
    end
    remove_column :moves, :move_type
    remove_column :moves, :eliminated_pawn
    remove_column :moves, :promotion_type
  end
end
