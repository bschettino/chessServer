class GameHelper

  def self.piece_to_api(type, players, player)
    case type
      when Piece::TYPE_ROOK
        piece = 't'
      when Piece::TYPE_KNIGHT
        piece = 'c'
      when Piece::TYPE_BISHOP
        piece = 'b'
      when Piece::TYPE_QUEEN
        piece =  'q'
      when Piece::TYPE_KING
        piece =  'r'
      when Piece::TYPE_PAWN
        piece =  'p'
      else
        piece =  'v'
    end
    piece = piece.upcase if player == players.first
    piece
  end
end