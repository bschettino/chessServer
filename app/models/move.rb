#encoding: utf-8
class Move < ActiveRecord::Base
  attr_accessible :game_player_id, :game_player, :legal, :validation_time, :move_type, :eliminated_pawn, :promotion_type

  belongs_to :game_player
  has_one :game, :through => :game_player
  has_one :player, :through => :game_player
  has_many :movimentations

  TYPE_NORMAL = 0
  TYPE_CASTLING = 1
  TYPE_EN_PASSANT = 2
  TYPE_PROMOTION = 3
  TYPES = [TYPE_NORMAL, TYPE_CASTLING, TYPE_EN_PASSANT, TYPE_PROMOTION]

  validates :move_type, :inclusion => {:in => TYPES}
  validates :promotion_type, :inclusion => {:in => Piece::TYPES}, :if => :type_promotion
  validates :eliminated_pawn, :presence => true, :if => :type_en_passant

  def self.create_move(params, gp)
    case params[:type].to_i
      when TYPE_NORMAL
        move = Move.create!(:move_type => TYPE_NORMAL, :game_player_id => gp.id)
        Movimentation.create!(:from => params[:move_from], :to => params[:move_to], :move_id => move.id)
        move
      when TYPE_CASTLING
        move = Move.create!(:move_type => TYPE_CASTLING, :game_player_id => gp.id)
        Movimentation.create!(:from => params[:rook_from], :to => params[:rook_to], :move_id => move.id)
        Movimentation.create!(:from => params[:king_from], :to => params[:king_to], :move_id => move.id)
        move
      when TYPE_EN_PASSANT
        move = Move.create!(:move_type => TYPE_EN_PASSANT, :game_player_id => gp.id, :eliminated_pawn => params[:eliminated_pawn])
        Movimentation.create!(:from => params[:move_from], :to => params[:move_to], :move_id => move.id)
        move
      when TYPE_PROMOTION
        move = Move.create!(:move_type => TYPE_PROMOTION, :game_player_id => gp.id, :promotion_type => params[:promotion_type])
        Movimentation.create!(:from => params[:move_from], :to => params[:move_to], :move_id => move.id)
        move
    end
  end


  def player_validate(valid)
    self.legal = (valid == 'true') ? true : false
    self.validation_time = Time.now
    self.move_on_game if self.legal
    self.save
  end

  def move_on_game
    self.movimentations.each do |movimentation|
      square_from = self.game.squares.where(:column => movimentation.from[0], :line => movimentation.from[1]).last
      square_to = self.game.squares.where(:column => movimentation.to[0], :line => movimentation.to[1]).last
      square_to.piece.kill if square_to.piece
      square_to.piece = square_from.piece
      square_to.save
      square_from.piece = nil
      square_from.save
    end
    case self.move_type
      when TYPE_EN_PASSANT
        square = self.game.squares.where(:column => self.eliminated_pawn[0], :line => self.eliminated_pawn[1]).last
        square.piece.kill if square.piece
        square.piece = nil
        square.save
      when TYPE_PROMOTION
        movimentation = self.movimentations.last
        square = self.game.squares.where(:column => movimentation.to[0], :line => movimentation.to[1]).last
        square.piece.kill if square.piece
        square.piece = Piece.new(:kind => self.promotion_type, :player_id => self.player, :game_id => self.game)
        square.save
    end

  end

  def type_promotion
    self.move_type == TYPE_PROMOTION
  end

  def type_en_passant
    self.move_type == TYPE_EN_PASSANT
  end

  def to_hash
    h = {}
    h[:id] = self.id
    h[:move_type] = self.move_type
    h[:legal] = self.legal
    h[:validation_time] = self.validation_time
    h[:movimentations] = []
    self.movimentations.each do |m|
      h[:movimentations] << {:from => m.from, :to => m.to}
    end
    case move_type
      when TYPE_EN_PASSANT
        h[:eliminated_pawn] = self.eliminated_pawn
      when TYPE_PROMOTION
        h[:promotion_type] = self.promotion_type
    end
    h
  end

end
