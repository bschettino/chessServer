#encoding: utf-8
class Movimentation < ActiveRecord::Base
  attr_accessible :to, :from, :move_id, :move

  belongs_to :move
  validates :move_id, :presence => true

end
