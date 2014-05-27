class CreateTableMovimentations < ActiveRecord::Migration
  def up
    create_table :movimentations do |t|
      t.string :from, :limit => 2
      t.string :to, :limit => 2
      t.integer :move_id
      t.timestamps
    end
  end

  def down
    drop_table :movimentations
  end
end
