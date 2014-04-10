#encoding: utf-8
class Player < ActiveRecord::Base

  attr_accessible :name

  has_many :games, :through => :game_players
  has_many :game_players

  validates :name, :presence => true, :uniqueness => true

end
