require 'spec_helper'

describe Gearbox do

  describe '#shift_gear' do
    context 'clutch is pressed' do
      context 'speed is in range' do
        it 'returns max speed in given range' do
          gearbox = Gearbox.new
          expect(gearbox.shift_gear(gear_range: 60...90, clutch_pressed: true, speed: 78)).to eq 89
          expect(gearbox.shift_gear(gear_range: 20...40, clutch_pressed: true, speed: 23)).to eq 39
        end

        it 'shifts gear to the given gear' do
          gearbox = Gearbox.new
          gearbox.shift_gear(gear_range: gearbox.gear_four, clutch_pressed: true, speed: 78)
          expect(gearbox.gear).to eq 60...90

          gearbox.shift_gear(gear_range: gearbox.gear_five, clutch_pressed: true, speed: 102)
          expect(gearbox.gear).to eq 90...140
        end
      end

      context 'speed is not in range' do
        it 'allows shifting gear to four only when the speed is in range' do
          gearbox = Gearbox.new
          expect{
            gearbox.shift_gear(gear_range: gearbox.gear_four, clutch_pressed: true, speed: 45)
          }.to raise_error Gearbox::IncorrectSpeedException, 'Incorrect speed to shift this gear. Adjust speed'
        end
      end
    end

    context 'clutch is not pressed' do
      it 'allows to shift gear only with clutch pressed' do
        gearbox = Gearbox.new
        expect{
          gearbox.shift_gear(gear_range: gearbox.gear_four, clutch_pressed: false, speed: 67)
        }.to raise_error Car::ClutchNotPressedError, 'Clutch is not pressed'
      end
    end
  end
end
