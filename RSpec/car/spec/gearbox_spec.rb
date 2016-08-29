require 'spec_helper'

describe Gearbox do

  describe '#shift_gear' do
    context 'clutch is pressed' do
      context 'speed is in range' do
        it 'returns max speed in 60..90 range' do
          gearbox = Gearbox.new(false, 78)
          gearbox.is_clutch_pressed = true
          expect(gearbox.shift_gear(60...90)).to eq 89
        end

        it 'returns to max speed in 20..40 range' do
          gearbox = Gearbox.new(false, 22)
          gearbox.is_clutch_pressed = true
          expect(gearbox.shift_gear(20...40)).to eq 39
        end

        it 'shifts gear to gear four' do
          gearbox = Gearbox.new(false, 78)
          gearbox.is_clutch_pressed = true
          gearbox.shift_gear(60...90)
          expect(gearbox.gear).to eq :four
        end
      end

      context 'speed is not in range' do
        it 'allows shifting gear to two only when the speed is in range' do
          gearbox = Gearbox.new(false, 13)
          gearbox.is_clutch_pressed = true
          expect{
            gearbox.shift_gear(20...40)
          }.to raise_error Gearbox::IncorrectSpeedException, 'Incorrect speed to shift gear two. Adjust speed'
        end

        it 'allows shifting gear to four only when the speed is in range' do
          gearbox = Gearbox.new(false, 13)
          gearbox.is_clutch_pressed = true
          expect{
            gearbox.shift_gear(60...90)
          }.to raise_error Gearbox::IncorrectSpeedException, 'Incorrect speed to shift gear four. Adjust speed'
        end
      end
    end

    context 'clutch is not pressed' do
      it 'allows to shift gear only with clutch pressed' do
        gearbox = Gearbox.new(false, 78)
        expect{
          gearbox.shift_gear(60...90)
        }.to raise_error Car::ClutchNotPressedError, 'Clutch is not pressed'
      end
    end
  end
end

