# wypadek (metoda dla Car) - wyslanie powiadomienia do firmy ubezpieczeniowej

describe Car do
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
      expectations = {head: false, tail: false, brake: false, left_turn: false, right_turn: false}
      expect(peugeot207.lights).to eq expectations
    end
  end

  describe '#show_car' do
    it 'presents car name, brand and model' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207.show_car).to eq "Name: Peugeot 207\nBrand: Peugeot\nModel: 207\nTransmission: 5-speed"
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

    context 'it is not the case of emergency' do
      it 'turns the lights off' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.lights = {head: true, tail: false, brake: true, left_turn: false, right_turn: true}
        peugeot207.stop_engine
        expect(peugeot207.lights).to eq(head: false, tail: false, brake: false, left_turn: false, right_turn: false)
      end
    end

    context 'it is the case of emergency' do
      it 'turns the lights off excluding emergency lights' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.turn_on_the_turn_lights
        peugeot207.stop_engine
        expectations = {head: false, tail: false, brake: false, left_turn: true, right_turn: true}
        expect(peugeot207.lights).to eq expectations
      end
    end
  end

  describe '#turn' do
    it 'turns the turn lights on for given direction' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.turn('right')
      expect(peugeot207.lights[:right_turn]).to eq true
    end
  end

  describe '#end_turn' do
    context 'it is not the case of emergency' do
      it 'turns the turn lights off' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.turn('right')
        peugeot207.end_turn
        expect(peugeot207.lights[:left_turn] || peugeot207.lights[:right_turn]).to eq false
      end
    end

    context 'it is the case of emergency' do
      it 'it does not turn the turn lights off' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.turn_on_the_turn_lights
        expect{
          peugeot207.end_turn
        }.to raise_error Car::CaseOfEmergencyException, 'Warning! Hazard on the road. Do not turn emergency lights off!'
      end
    end
  end

  describe '#turn_on_the_turn_lights' do
    it 'turns the emergency lights on' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.turn_on_the_turn_lights
      expect(peugeot207.lights[:left_turn] && peugeot207.lights[:right_turn]).to eq true
    end
  end

  describe '#turn_off_the_turn_lights' do
    it 'turns the emergency lights off' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.turn_on_the_turn_lights
      peugeot207.turn_off_the_turn_lights
      expect(peugeot207.lights[:left_turn] || peugeot207.lights[:right_turn]).to eq false
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

  describe '#shift_gear' do
    context 'clutch is pressed' do
      context 'speed is in range' do
        it 'accelerates car to max speed in given range' do
          peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
          peugeot207.clutch = true
          peugeot207.speed = 78
          peugeot207.shift_gear(:four)
          expect(peugeot207.speed).to eq 90
        end

        it 'shifts gear to given gear' do
          peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
          peugeot207.clutch = true
          peugeot207.speed = 78
          peugeot207.shift_gear(:four)
          expect(peugeot207.gear).to eq :four
        end

        it 'turns the tail lights off' do
          peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
          peugeot207.clutch = true
          peugeot207.speed = 78
          peugeot207.lights[:tail] = true
          peugeot207.shift_gear(:four)
          expect(peugeot207.lights[:tail]).to eq false
        end
      end

      context 'speed is not in range' do
        it 'allows to shift gear only when the speed is in range' do
          peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
          peugeot207.clutch = true
          peugeot207.speed = 78
          expect{
            peugeot207.shift_gear(:five)
          }.to raise_error Car::IncorrectSpeedException, 'Incorrect speed to shift gear five. Adjust speed'
        end
      end
    end

    context 'clutch is not pressed' do
      it 'allows to shift gear only with clutch pressed' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.clutch = false
        expect{
          peugeot207.shift_gear(:two)
        }.to raise_error Car::ClutchNotPressedError, 'Clutch is not pressed'
      end
    end
  end

  describe '#shift_neutral_gear' do
    it 'shifts gear to neutral position' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.gear = :three
      peugeot207.shift_neutral_gear
      expect(peugeot207.gear).to eq :neutral
    end
    it 'turns the tail lights off' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.lights[:tail] = true
      peugeot207.shift_neutral_gear
      expect(peugeot207.lights[:tail]).to eq false
    end
  end

  describe '#shift_reverse_gear' do
    context 'speed is equal to 0' do
      it 'shifts gear to reverse position' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 0
        peugeot207.gear = :one
        peugeot207.shift_reverse_gear
        expect(peugeot207.gear).to eq :reverse
      end

      it 'turns the tail lights on' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.shift_reverse_gear
        expect(peugeot207.lights[:tail]).to eq true
      end
    end
    context 'speed is higher than 0' do
      it 'allows to shift reverse gear only when the car is standing' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
        peugeot207.speed = 12
        expect{
          peugeot207.shift_reverse_gear
        }.to raise_error Car::IncorrectSpeedException, 'Incorrect speed to reverse. Stop the car'
      end
    end
  end

  describe '#accident_occured' do
    context 'car driver caused an accident' do
      context 'driver is insured' do
        it 'sends a message to the Insurance Company' do
          jake = Person.new(name: 'Jake')
          peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: jake)
          seat_ibiza = Car.new(name: 'Seat Ibiza', brand: 'Seat', model: 'Ibiza')
        end
      end
      context 'driver is not insured' do
        it 'sends a message only when person is insured' do

        end
      end
    end
    context 'Someone else caused an accident' do

    end
  end
end
