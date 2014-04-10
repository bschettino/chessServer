#encoding: utf-8
class Square < ActiveRecord::Base
  attr_accessible :line, :column, :game_id, :game, :piece, :piece_id

  belongs_to :piece
  belongs_to :game

  validates :line, :presence => true, :inclusion => {:in => 1..8}
  validates :column, :presence => true, :inclusion => {:in => 'a'..'h'}
  validates :game_id, :presence => true

  def add_player(player)
    piece = self.piece
    piece.player_id = player.id
    piece.save!
  end


end
