require 'spec_helper'

describe Lights do

  describe '#change_lamps_state' do
    it 'turns all lamps on,
        when :all given as a parameter' do
      lights = Lights.new
      lights.change_lamps_state(:all, state: true)
      expect(lights.show_lamps_state.all?{|state| state == true}).to eq true
    end

    it 'turns specific lamps off' do
      lights = Lights.new
      lights.change_lamps_state(lights.tail, lights.brake, state: true)
      expect(lights.tail.is_turned_on).to eq true
      expect(lights.brake.is_turned_on).to eq true
    end
  end

  describe '#emergency_lights_turned_on?' do
    it 'returns true if left and right turn are on' do
      lights = Lights.new
      lights.left_turn.is_turned_on = true
      lights.right_turn.is_turned_on = true
      expect(lights.emergency_lights_turned_on?).to eq true
    end

    it 'returns true if left or right turn is off' do
      lights = Lights.new
      lights.left_turn.is_turned_on = false
      lights.right_turn.is_turned_on = true
      expect(lights.emergency_lights_turned_on?).to eq false
    end
  end
end
