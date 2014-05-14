#encoding: utf-8
class Move < ActiveRecord::Base
  attr_accessible :to, :from, :game_player_id, :game_player, :legal, :validation_time

  belongs_to :game_player
  has_one :game, :through => :game_player
  has_one :player, :through => :game_player


  def player_validate(valid)
    self.legal = (valid == 'true') ? true : false
    self.validation_time = Time.now
    self.move_on_game if self.legal
    self.save
  end

  def move_on_game
    square_from  = self.game.squares.where(:column => self.from[0], :line => self.from[1]).last
    square_to  = self.game.squares.where(:column => self.to[0], :line => self.to[1]).last
    square_to.piece.kill if square_to.piece
    square_to.piece = square_from.piece
    square_to.save
    square_from.piece = nil
    square_from.save
  end

end
