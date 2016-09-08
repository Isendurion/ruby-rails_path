class Lights

  attr_accessor :head, :tail, :brake, :left_indicator, :right_indicator, :lamps

  def initialize(head: Lamp.new('head', false),
                 tail: Lamp.new('tail', false),
                 brake: Lamp.new('brake', false),
                 left_indicator: Lamp.new('left_indicator', false),
                 right_indicator: Lamp.new('right_indicator', false))
    @head = head
    @tail = tail
    @brake = brake
    @left_indicator = left_indicator
    @right_indicator = right_indicator
    @lamps = []
    @lamps << @head << @tail << @brake << @left_indicator << @right_indicator
  end

  def show_lamps_state
    lamps.map(&:is_turned_on)
  end

  def emergency_lights_turned_on?
    left_indicator.is_turned_on && right_indicator.is_turned_on
  end

  def turn_on_lamps!(*lamps)
    lamps.each(&:turn_on!)
  end

  def turn_off_lamps!(*lamps)
    lamps.each(&:turn_off!)
  end
end
