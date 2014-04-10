#encoding: utf-8
class Game < ActiveRecord::Base
  attr_accessible :winner, :winner_id, :moves_count, :over

  has_many :players, :through => :game_players
  has_many :game_players
  has_many :squares
  belongs_to :winner, :class_name => Player


  def add_player(player)
    return {:code => HttpResponse::CODE_ALREADY_PLAYING, :message => HttpResponse.code_msg(HttpResponse::CODE_ALREADY_PLAYING)} if self.players.include?(player)
    return {:code => HttpResponse::CODE_MAX_NUMBER_REACHED, :message => HttpResponse.code_msg(HttpResponse::CODE_MAX_NUMBER_REACHED)} if self.players.count > 1
    GamePlayer.create(:game => self, :player => player)
    if self.players.count == 1
      ('a'..'h').each do |c|
        (1..2).each do |l|
          self.squares.where(:column => c, :line => l).last.add_player(player)
        end
      end
    else
      ('a'..'h').each do |c|
        (7..8).each do |l|
          self.squares.where(:column => c, :line => l).last.add_player(player)
        end
      end
    end
  end

  def self.create_game(params = {})
    game = Game.create!(params)
    game.create_board
    game
  end

  def current_board
    board = {}
    self.squares.each do |s|
      board["#{s.column}#{s.line}".to_sym] = GameHelper.piece_to_api(s.piece.try(:kind), self.players, s.piece.try(:player))
    end
    board
  end

  def create_board
    ('a'..'h').each do |c|
      (1..8).each do |l|
        piece = nil
        if (l<3 || l >6) #squares that have pieces on the initial position
          if [2, 7].include?(l) #PAWN's squares
            piece = Piece.create!(:kind => Piece::TYPE_PAWN)
          else
            case c
              when 'a', 'h'
                piece = Piece.create!(:kind => Piece::TYPE_ROOK)
              when 'b', 'g'
                piece = Piece.create!(:kind => Piece::TYPE_KNIGHT)
              when 'c', 'f'
                piece = Piece.create!(:kind => Piece::TYPE_BISHOP)
              when 'd'
                piece = Piece.create!(:kind => Piece::TYPE_QUEEN)
              when 'e'
                piece = Piece.create!(:kind => Piece::TYPE_KING)
              else
            end
          end
        end
        piece_id = piece.id if piece
        Square.create!(:column => c, :line => l, :game_id => self.id, :piece_id => piece_id)
      end
    end
  end

end
