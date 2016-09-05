Lamp = Struct.new(:name, :is_turned_on) do
  def change_lamp_state
    self.is_turned_on = !(self.is_turned_on)
  end
end

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
    instance_variables.map{|lamp| instance_variable_get(lamp).is_turned_on}
  end

  def change_lamps_state(*lamps, should_be_turned_on:)
    if lamps == [:all]
      lamps.delete(:all)
      instance_variables.each do |lamp|
        lamps << instance_variable_get(lamp)
      end
    end
    lamps.each{|lamp| lamp.is_turned_on = should_be_turned_on}
  end

  def emergency_lights_turned_on?
    @left_turn.is_turned_on && @right_turn.is_turned_on
  end
end
