require 'spec_helper'

describe CarDataFile do
  describe '#export' do
    it 'creates new file' do
      car_data_file = CarDataFile.new(Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake')))
      allow(File).to receive(:new)
      car_data_file.export
      expect(File).to have_received(:new)
    end

    it 'gives car name as a name to the file' do
      car_data_file = CarDataFile.new(Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake')))
      allow(File).to receive(:new)
      car_data_file.export
      expect(File).to have_received(:new).with('Peugeot_207.txt', 'w')
    end

    it 'saves car properties to the file' do
      car_data_file = CarDataFile.new(Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake')))
      allow(File).to receive(:write)
      car_data_file.export
      expect(File).to have_received(:write).with('Peugeot_207.txt', "Name: Peugeot 207\nBrand: Peugeot\nModel: 207\nTransmission: 5-speed\n")
      File.delete('Peugeot_207.txt')
    end
  end

  describe '#import' do
    it 'makes new car' do
      car_data_file = CarDataFile.new('')
      car_data_file.import('Seat_Ibiza.txt')
      expect(car_data_file.car).to be_a_kind_of Car
    end

    it 'sets car parameters from the file' do
      car_data_file = CarDataFile.new('')
      car_data_file.import('Seat_Ibiza.txt')
      expect(car_data_file.car_name).to eq 'Seat Ibiza'
      expect(car_data_file.car_brand).to eq 'Seat'
      expect(car_data_file.car_model).to eq 'Ibiza'
      expect(car_data_file.car_driver_name).to eq 'Gregory'
    end
  end
end
