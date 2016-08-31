require 'spec_helper'

describe Gearbox do

  describe '#shift_gear' do
    context 'clutch is pressed' do
      context 'speed is in range' do
        it 'returns max speed in 60...90 range' do
          gearbox = Gearbox.new
          expect(gearbox.shift_gear(gear_range: 60...90, clutch_pressed: true, speed: 78)).to eq 89
        end

        it 'returns to max speed in 20...40 range' do
          gearbox = Gearbox.new
          expect(gearbox.shift_gear(gear_range: 20...40, clutch_pressed: true, speed: 23)).to eq 39
        end

        it 'shifts gear to gear four' do
          gearbox = Gearbox.new
          gearbox.shift_gear(gear_range: gearbox.gears.four, clutch_pressed: true, speed: 78)
          expect(gearbox.gear).to eq 60...90
        end
      end

      context 'speed is not in range' do
        it 'allows shifting gear to four only when the speed is in range' do
          gearbox = Gearbox.new
          expect{
            gearbox.shift_gear(gear_range: gearbox.gears.four, clutch_pressed: true, speed: 45)
          }.to raise_error Gearbox::IncorrectSpeedException, 'Incorrect speed to shift this gear. Adjust speed'
        end
      end
    end

    context 'clutch is not pressed' do
      it 'allows to shift gear only with clutch pressed' do
        gearbox = Gearbox.new
        expect{
          gearbox.shift_gear(gear_range: gearbox.gears.four, clutch_pressed: false, speed: 67)
        }.to raise_error Car::ClutchNotPressedError, 'Clutch is not pressed'
      end
    end
  end

  describe '#shift_neutral_gear' do
    it 'shifts gear to neutral position' do
      gearbox = Gearbox.new
      gearbox.shift_neutral_gear
      expect(gearbox.gear).to eq 0
    end
  end
end

describe '#shift_reverse_gear' do
  context 'speed is equal to 0' do
    it 'shifts gear to reverse position' do
      gearbox = Gearbox.new
      gearbox.shift_reverse_gear(0)
      expect(gearbox.gear).to eq 0..10
    end
  end
  context 'speed is higher than 0' do
    it 'allows to shift reverse gear only when the car speed is equal 0' do
      gearbox = Gearbox.new
      expect{
        gearbox.shift_reverse_gear(98)
      }.to raise_error Gearbox::IncorrectSpeedException, 'Incorrect speed to reverse. Stop the car first'
    end
  end
end
