# wypadek (metoda dala Car) - wyslanie powiadomienia do firmy ubezpieczeniowej

# extend lights to turn_lights, emergency_lights

# stworzyc 2 instancje Car, oba maja miec swiatla wlaczone. Wylaczyc w jednym, sprawdzac czy w drugim tez sa wylaczone
# hit_the_brakes => zmienic nazwe
# poprawic nazwy metod - dodac okreslenia
require 'spec_helper'

RSpec.describe Car do
  describe '.new' do
    it 'creates new car with given name, brand and model' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207).to be_a_kind_of Car
    end

    it 'creates car with speed set to 0' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207.speed).to eq 0
    end

    it 'creates car with a gear set to neutral' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207.gear).to eq :neutral
    end

    it 'creates car with a clutch not pressed' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207.clutch).to eq false
    end

    it 'creates car with lights turned off' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207.lights.values.any?).to eq false
    end
  end

  describe '#show_car' do
    it 'presents car name, brand and model' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207.show_car).to eq "Name: Peugeot 207\nBrand: Peugeot\nModel: 207"
    end
  end

  describe '#start_engine' do
    let(:peugeot207) { Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207') }

    context 'clutch is pressed' do
      before { peugeot207.clutch = true }

      it 'sets speed to 0' do
        peugeot207.start_engine
        expect(peugeot207.speed).to eq 0
      end

      it 'turns head lights on' do
        peugeot207.start_engine
        expect(peugeot207.lights[:head]).to eq true
      end
    end

    context 'clutch is not pressed' do
      before { peugeot207.clutch = false }

      it 'allows to start engine only with clutch pressed' do
        expect{
          peugeot207.start_engine
        }.to raise_error Car::ClutchNotPressedError, 'Clutch is not pressed'
      end
    end
  end

  describe '#stop_engine' do
    it 'sets speed to 0' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.stop_engine
      expect(peugeot207.speed).to eq 0
    end

    it 'turns the lights off' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.stop_engine
      expect(peugeot207.lights[:head]).to eq false
    end
  end

  describe '#hit_the_brakes' do
    it 'turns the brake lights on' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.speed = 120
      peugeot207.hit_the_brakes(30)
      expect(peugeot207.lights[:brake]).to eq true
    end

    it 'sets speed to given value' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.speed = 120
      peugeot207.hit_the_brakes(30)
      expect(peugeot207.speed).to eq 30
    end
  end

  describe '#release_brakes' do
    it 'turns the brake_lights off' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.lights[:brake] = true
      peugeot207.release_brakes
      expect(peugeot207.lights[:brake]).to eq false
    end
  end

  describe '#set_gear' do
    context 'clutch is pressed' do
      context 'speed is in range' do
        it 'accelerates car to max speed in given range' do
          peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
          peugeot207.clutch = true
          peugeot207.speed = 78
          peugeot207.set_gear(:four)
          expect(peugeot207.speed).to eq 90
        end

        it 'sets gear to given gear' do
          peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
          peugeot207.clutch = true
          peugeot207.speed = 78
          peugeot207.set_gear(:four)
          expect(peugeot207.gear).to eq :four
        end

        it 'turns the tail lights off' do
          peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
          peugeot207.clutch = true
          peugeot207.speed = 78
          peugeot207.lights[:tail] = true
          peugeot207.set_gear(:four)
          expect(peugeot207.lights[:tail]).to eq false
        end
      end

      context 'speed is not in range' do
        it 'allows switching to the given gear only when the speed is in range' do
          peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
          peugeot207.clutch = true
          peugeot207.speed = 78
          expect{
            peugeot207.set_gear(:five)
          }.to raise_error Car::IncorrectSpeedException, 'Incorrect speed to switch to gear five. Adjust speed'
        end
      end
    end

    context 'clutch is not pressed' do
      it 'allows switching gear only with clutch pressed' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.clutch = false
        expect{
          peugeot207.set_gear(:two)
        }.to raise_error Car::ClutchNotPressedError, 'Clutch is not pressed'
      end
    end
  end

  describe '#set_neutral_gear' do
    it 'sets gear to neutral position' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.gear = :three
      peugeot207.set_neutral_gear
      expect(peugeot207.gear).to eq :neutral
    end
    it 'turns the tail lights off' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.lights[:tail] = true
      peugeot207.set_neutral_gear
      expect(peugeot207.lights[:tail]).to eq false
    end
  end

  describe '#set_reverse_gear' do
    context 'speed is equal to 0' do
      it 'sets gear to reverse position' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 0
        peugeot207.gear = :one
        peugeot207.set_reverse_gear
        expect(peugeot207.gear).to eq :reverse
      end

      it 'turns the tail lights on' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.set_reverse_gear
        expect(peugeot207.lights[:tail]).to eq true
      end
    end
    context 'speed is higher than 0' do
      it 'allows to set reverse position only when the car is standing' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 12
        expect{
          peugeot207.set_reverse_gear
        }.to raise_error Car::IncorrectSpeedException, 'Incorrect speed to reverse. Stop the car'
      end
    end
  end
end
