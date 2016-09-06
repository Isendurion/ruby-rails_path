require 'spec_helper'

describe Lamp do
  describe '#switch' do
    it 'switches lamp on/off' do
      lamp = Lamp.new('head', true)
      lamp.switch(state: false)
      expect(lamp.is_turned_on).to eq false
    end
  end
end
