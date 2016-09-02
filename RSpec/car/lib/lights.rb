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

  def show_lamps_state
    lamps_state = []
    self.instance_variables.each{|lamp| lamps_state << self.instance_variable_get(lamp).is_turned_on}
    lamps_state
  end

  def change_lamps_state(*lamps, state:)
    if lamps == [:all]
      self.instance_variables.each do |lamp|
        lamps.delete(:all)
        lamps << self.instance_variable_get(lamp)
      end
    end
    lamps.each{|lamp| lamp.is_turned_on = state}
  end

  def emergency_lights_turned_on?
    @left_turn.is_turned_on && @right_turn.is_turned_on
  end
end
