#encoding: utf-8
class GameOverRequest < ActiveRecord::Base
  attr_accessible :game_id, :winner_id, :requestor_id, :requestor, :game, :winner, :legal, :validation_time

  belongs_to :game
  belongs_to :winner, :class_name => Player
  belongs_to :requestor, :class_name => GamePlayer

  def player_validate(valid)
    self.legal = valid
    self.validation_time = Time.now
    self.finish_game if self.legal
    self.save
  end

  def finish_game
    game = self.game
    game.winner = self.winner
    game.save
  end

end
