require 'spec_helper'

describe Lamp do
  describe '#switch' do
    it 'switches lamp on/off' do
      lamp = Lamp.new('head', true)
      lamp.turn_off!
      expect(lamp.is_turned_on).to eq false
    end
  end

  describe '#turn_off!' do
    it 'sends switch with off state to the lamp' do
      lamp = Lamp.new('head', true)
      allow(lamp).to receive(:switch)
      lamp.turn_off!
      expect(lamp).to have_received(:switch).with(state: false)
    end
  end

  describe '#turn_on!' do
    it 'sends switch with on state to the lamp' do
      lamp = Lamp.new('head', true)
      allow(lamp).to receive(:switch)
      lamp.turn_on!
      expect(lamp).to have_received(:switch).with(state: true)
    end
  end
end
