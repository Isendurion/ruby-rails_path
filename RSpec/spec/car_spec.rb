#RSpec:
# car

# wypadek - wyslanie powiadomienia do firmy ubezpieczeniowej

require 'car'

RSpec.describe Car do
  describe '.new' do
    it 'creates new car with given name, brand and model' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207).to be_a_kind_of Car
    end
  end

  describe '#show_car' do
    it 'presents car name, brand and model' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207.show_car).to eq "Name: Peugeot 207\nBrand: Peugeot\nModel: 207"
    end
  end

  describe '#start_engine' do
    it 'sets speed to 0' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207.speed).to eq 0
    end
  end

  describe '#stop_engine' do
    it 'sets speed to 0' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207.speed).to eq 0
    end
  end

  describe '#gear_1' do
    context 'speed is in range' do
      it 'accelerates car to max speed in given range' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 14
        peugeot207.gear_1
        expect(peugeot207.speed).to eq 20
      end

      it 'sets gear to 1' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 14
        peugeot207.gear_1
        expect(peugeot207.gear).to eq :one
      end
    end

    context 'speed is not in range' do
      it 'allows switching to the gear 1 only when the speed is in range' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 21
        expect {
          peugeot207.gear_1
        }.to raise_error Car::IncorrectSpeedException, 'Incorrect speed to switch to gear one. Adjust speed'
      end
    end
  end

  describe '#gear_2' do
    context 'speed is in range' do
      it 'accelerates car to max speed in given range' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 28
        peugeot207.gear_2
        expect(peugeot207.speed).to eq 40
      end

      it 'sets gear to 2' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 28
        peugeot207.gear_2
        expect(peugeot207.gear).to eq :two
      end
    end

    context 'speed is not in range' do
      it 'allows switching to the gear 2 only when the speed is in range' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 12
        expect {
          peugeot207.gear_2
        }.to raise_error Car::IncorrectSpeedException, 'Incorrect speed to switch to gear two. Adjust speed'
      end
    end
  end

  describe '#gear_3' do
    context 'speed is in range' do
      it 'accelerates car to max speed in given range' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 56
        peugeot207.gear_3
        expect(peugeot207.speed).to eq 60
      end

      it 'sets gear to 3' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 56
        peugeot207.gear_3
        expect(peugeot207.gear).to eq :three
      end
    end

    context 'speed is not in range' do
      it 'allows switching to the gear 3 only when the speed is in range' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 37
        expect {
          peugeot207.gear_3
        }.to raise_error Car::IncorrectSpeedException, 'Incorrect speed to switch to gear three. Adjust speed'
      end
    end
  end

  describe '#gear_4' do
    context 'speed is in range' do
      it 'accelerates car to max speed in given range' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 69
        peugeot207.gear_4
        expect(peugeot207.speed).to eq 90
      end

      it 'sets gear to 4' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 69
        peugeot207.gear_4
        expect(peugeot207.gear).to eq :four
      end
    end

    context 'speed is not in range' do
      it 'allows switching to the gear 4 only when the speed is in range' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 53
        expect {
          peugeot207.gear_4
        }.to raise_error Car::IncorrectSpeedException, 'Incorrect speed to switch to gear four. Adjust speed'
      end
    end
  end

  describe '#gear_5' do
    context 'speed is in range' do
      it 'accelerates car to max speed in given range' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 127
        peugeot207.gear_5
        expect(peugeot207.speed).to eq 140
      end

      it 'sets gear to 5' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 127
        peugeot207.gear_5
        expect(peugeot207.gear).to eq :five
      end
    end

    context 'speed is not in range' do
      it 'allows switching to the gear 5 only when the speed is in range' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 85
        expect {
          peugeot207.gear_5
        }.to raise_error Car::IncorrectSpeedException, 'Incorrect speed to switch to gear five. Adjust speed'
      end
    end
  end

  describe '#gear_neutral' do
    it 'sets gear to neutral position' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.gear = :three
      peugeot207.gear_neutral
      expect(peugeot207.gear).to eq :neutral
    end
  end

  describe '#gear_reverse' do
    context 'speed is equal to 0' do
      it 'sets gear to reverse position' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 0
        peugeot207.gear = :one
        peugeot207.gear_reverse
        expect(peugeot207.gear).to eq :reverse
      end
    end
    context 'speed is higher than 0' do
      it 'allows to set reverse position only when the car is standing' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 12
        expect{
          peugeot207.gear_reverse
        }.to raise_error Car::IncorrectSpeedException, 'Incorrect speed. Stop the car'
      end
    end
  end
end
