require 'spec_helper'

describe Lights do

  describe '#show_lamps_state' do
    it 'shows in an array are particular lamps turned on or off' do
      lights = Lights.new
      lights.left_indicator.turn_on!
      lights.right_indicator.turn_on!
      expect(lights.show_lamps_state).to eq [false, false, false, true, true]
    end
  end

  describe '#emergency_lights_turned_on?' do
    it 'returns true if left and right turn are on' do
      lights = Lights.new
      lights.left_indicator.turn_on!
      lights.right_indicator.turn_on!
      expect(lights.emergency_lights_turned_on?).to eq true
    end

    it 'returns true if left or right turn is off' do
      lights = Lights.new
      lights.left_indicator.turn_off!
      lights.right_indicator.turn_on!
      expect(lights.emergency_lights_turned_on?).to eq false
    end
  end

  describe '#turn_on_lamps!' do
    it 'turns on given lamps' do
      lights = Lights.new
      lights.head.turn_on!
      expect(lights.head.is_turned_on).to eq true
    end
  end

  describe '#turn_on_lamps!' do
    it 'turns on given lamps' do
      lights = Lights.new
      lights.head.turn_off!
      expect(lights.head.is_turned_on).to eq false
    end
  end
end
