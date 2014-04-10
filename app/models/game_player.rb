#encoding: utf-8
class GamePlayer < ActiveRecord::Base
  attr_accessible :player, :player_id, :game, :game_id

  belongs_to :game
  belongs_to :player

end
