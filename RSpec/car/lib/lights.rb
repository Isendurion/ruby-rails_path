Lamp = Struct.new(:name, :is_turned_on)

class Lights
  attr_accessor :head, :tail, :brake, :left_turn, :right_turn

  def initialize(head: Lamp.new('head', false),
                 tail: Lamp.new('tail', false),
                 brake: Lamp.new('brake', false),
                 left_turn: Lamp.new('left_turn', false),
                 right_turn: Lamp.new('right_turn', false))
    @head = head
    @tail = tail
    @brake = brake
    @left_turn = left_turn
    @right_turn = right_turn
  end

  def turn_on_the_lamps(*lamps)
    lamps.each{|lamp| lamp.is_turned_on = true}
  end

  def turn_off_the_lamps(*lamps)
    lamps.each{|lamp| lamp.is_turned_on = false}
  end

  def emergency_lights_turned_on?
    @left_turn.is_turned_on && @right_turn.is_turned_on
  end
end

