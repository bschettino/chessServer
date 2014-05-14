#encoding: utf-8
class GamePlayer < ActiveRecord::Base
  attr_accessible :player, :player_id, :game, :game_id

  belongs_to :game
  belongs_to :player
  has_many :moves

  after_initialize :init

  def init
    self.player_key  ||= Digest::SHA1.hexdigest("#{DateTime.now.to_i} #{rand(1000)}")
  end
end
