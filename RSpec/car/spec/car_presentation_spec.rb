require 'spec_helper'

describe CarPresentation do
  describe '#show_car' do
    it 'shows peugeot207 attributes' do
      car_presentation = CarPresentation.new('Peugeot207', 'Peugeot', '207', '5')
      expect(car_presentation.show_car).to eq "Name: Peugeot207\nBrand: Peugeot\nModel: 207\nTransmission: 5-speed"
    end
  end
end
