#encoding: utf-8
class Game < ActiveRecord::Base
  attr_accessible :winner, :winner_id, :moves_count, :over

  has_many :players, :through => :game_players
  has_many :moves, :through => :game_players
  has_many :game_players
  has_many :squares
  has_many :game_over_requests
  belongs_to :winner, :class_name => Player


  def add_player(player)
    return {:code => HttpResponse::CODE_ALREADY_PLAYING, :message => HttpResponse.code_msg(HttpResponse::CODE_ALREADY_PLAYING)} if self.players.include?(player)
    return {:code => HttpResponse::CODE_MAX_NUMBER_REACHED, :message => HttpResponse.code_msg(HttpResponse::CODE_MAX_NUMBER_REACHED)} if self.players.count > 1
    gp = GamePlayer.create(:game => self, :player => player)
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
    gp
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
            piece = Piece.create!(:kind => Piece::TYPE_PAWN, :game_id => self.id)
          else
            case c
              when 'a', 'h'
                piece = Piece.create!(:kind => Piece::TYPE_ROOK, :game_id => self.id)
              when 'b', 'g'
                piece = Piece.create!(:kind => Piece::TYPE_KNIGHT, :game_id => self.id)
              when 'c', 'f'
                piece = Piece.create!(:kind => Piece::TYPE_BISHOP, :game_id => self.id)
              when 'd'
                piece = Piece.create!(:kind => Piece::TYPE_QUEEN, :game_id => self.id)
              when 'e'
                piece = Piece.create!(:kind => Piece::TYPE_KING, :game_id => self.id)
              else
            end
          end
        end
        piece_id = piece.id if piece
        Square.create!(:column => c, :line => l, :game_id => self.id, :piece_id => piece_id)
      end
    end
  end

  def next_player
    last_move = self.moves.where('validation_time IS NULL').last
    return self.players.first unless last_move
    last_player = last_move.player
    next_player = self.players - [last_player]
    next_player.last
  end

end
