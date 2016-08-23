require 'forwardable'
require_relative 'pesant'

class Warrior
  extend Forwardable

  def_delegators :@recruit, :do_when_attacked

  def initialize
    @recruit = Pesant.new
    @recruit.action = 'fight'
  end

  def gain_strength
    @recruit.strength + 20
  end

  def weapon
    @recruit.weapon = 'Sword'
  end
end

recruit = Warrior.new
p recruit.do_when_attacked
