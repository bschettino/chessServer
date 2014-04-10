#encoding: utf-8
class Piece < ActiveRecord::Base
  attr_accessible :kind, :alive, :player_id, :player

  belongs_to :player
  has_one :square

  TYPE_ROOK = 0
  TYPE_KNIGHT = 1
  TYPE_BISHOP = 2
  TYPE_QUEEN = 3
  TYPE_KING = 4
  TYPE_PAWN = 5

  TYPES = [TYPE_ROOK, TYPE_KNIGHT, TYPE_BISHOP, TYPE_QUEEN, TYPE_KING, TYPE_PAWN]

  validates :kind, :presence => true, :inclusion => {:in => TYPES}

end
