require 'spec_helper'

describe Lights do
  describe '#turn_on_the lamps'do
    it 'turns on head and brake lamps' do
      lights = Lights.new
      lights.turn_on_the_lamps(lights.head, lights.brake)
      expect(lights.head.is_turned_on).to eq true
      expect(lights.brake.is_turned_on).to eq true
    end

    it 'turns on turns and brake lamps' do
      lights = Lights.new
      lights.turn_on_the_lamps(lights.left_turn, lights.right_turn, lights.brake)
      expect(lights.right_turn.is_turned_on).to eq true
      expect(lights.left_turn.is_turned_on).to eq true
      expect(lights.brake.is_turned_on).to eq true
    end
  end

  describe '#turn_off_the lamps'do
    it 'turns off head and brake lamps' do
      lights = Lights.new
      lights.turn_off_the_lamps(lights.head, lights.brake)
      expect(lights.head.is_turned_on).to eq false
      expect(lights.brake.is_turned_on).to eq false
    end

    it 'turns off turns and brake lamps' do
      lights = Lights.new
      lights.turn_off_the_lamps(lights.left_turn, lights.right_turn, lights.brake)
      expect(lights.right_turn.is_turned_on).to eq false
      expect(lights.left_turn.is_turned_on).to eq false
      expect(lights.brake.is_turned_on).to eq false
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
