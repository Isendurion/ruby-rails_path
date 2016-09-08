require 'spec_helper'

describe Lamp do
  describe '#turn_off!' do
    it 'turns off the lamp' do
      lamp = Lamp.new('head', true)
      lamp.turn_off!
      expect(lamp.is_turned_on).to eq false
    end
  end

  describe '#turn_on!' do
    it 'turns on the lamp' do
      lamp = Lamp.new('head', false)
      lamp.turn_on!
      expect(lamp.is_turned_on).to eq true
    end
  end
end
