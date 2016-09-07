class Lights

  attr_accessor :head, :tail, :brake, :left_turn, :right_turn, :lamps

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
    @lamps = []
    @lamps << @head << @tail << @brake << @left_turn << @right_turn
  end

  def show_lamps_state
    @lamps.map(&:is_turned_on)
  end

  def emergency_lights_turned_on?
    left_turn.is_turned_on && right_turn.is_turned_on
  end

  def turn_on_lamps!(*lamps)
    lamps.each(&:turn_on!)
  end

  def turn_off_lamps!(*lamps)
    lamps.each(&:turn_off!)
  end
end
