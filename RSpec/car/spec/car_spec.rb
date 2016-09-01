require 'spec_helper'

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

    it 'creates car with a clutch not pressed' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207.clutch).to eq false
    end

    it 'creates car with lights turned off' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      expect(peugeot207.lights).to eq(head: false, tail: false, brake: false, left_turn: false, right_turn: false)
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
        expect(peugeot207.llights.head.is_turned_on).to eq true
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
        peugeot207.lights[:left_turn] = true
        peugeot207.lights[:left_turn] = true
        peugeot207.stop_engine
        expect(peugeot207.lights).to eq(head: false, tail: false, brake: false, left_turn: true, right_turn: true)
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
        peugeot207.lights[:left_turn] = true
        peugeot207.lights[:right_turn] = true
        expect{
          peugeot207.end_turn
        }.to raise_error Car::CaseOfEmergencyException, 'Warning! Hazard on the road. Do not turn emergency lights off!'
      end
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

  describe '#turn_on_the_tail_lights' do
    it 'turns on the tail lights' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.turn_on_the_tail_lights
      expect(peugeot207.lights[:tail]).to eq true
    end
  end
  describe '#turn_off_the_tail_lights' do
    it 'turns off the tail lights' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
      peugeot207.turn_off_the_tail_lights
      expect(peugeot207.lights[:tail]).to eq false
    end
  end

  describe '#send_notification' do
    context 'receiver does not require keywords' do
      it 'sends message without keywords' do
        wayne = Person.new(name: 'Wayne')
        jake = Person.new(name: 'Jake')
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: jake)
        seat_ibiza = Car.new(name: 'Seat Ibiza', brand: 'Seat', model: 'Ibiza', driver: wayne)
        peugeot207.send_notification(seat_ibiza, 'Do not break so unexpectedly')
        expect(seat_ibiza.received_message).to eq Notification.new(peugeot207, seat_ibiza, 'Do not break so unexpectedly.')
      end

      it 'sends message only when keywords are not required' do
        wayne = Person.new(name: 'Wayne')
        jake = Person.new(name: 'Jake')
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: jake)
        seat_ibiza = Car.new(name: 'Seat Ibiza', brand: 'Seat', model: 'Ibiza', driver: wayne, is_keyword_required: true)
        expect{
          peugeot207.send_notification(seat_ibiza, 'Do not break so unexpectedly.')
        }.to raise_error Car::KeywordRequiredError, 'Keyword required. Sending aborted'
      end
    end

    context 'receiver requires keywords' do
      it 'sends message with keywords' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        jake = Person.new(name: 'Jake', insurance: liberty)
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: jake)
        expect(peugeot207.send_notification(liberty, 'Accident occured. Send car carrier', 'ACCIDENT')).to be_a_kind_of Notification
      end

      it 'sends message with accident pattern' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        jake = Person.new(name: 'Jake', insurance: liberty)
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: jake)
        peugeot207.send_notification(liberty, 'Accident occured. Send car carrier', liberty.notification_keywords[:accident])
        expect(liberty.received_message.message).to eq 'Accident occured. Send car carrier.ACCIDENT'
      end

      it 'sends message with other pattern' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        jake = Person.new(name: 'Jake', insurance: liberty)
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: jake)
        peugeot207.send_notification(liberty, 'Need new insurance', liberty.notification_keywords[:other])
        expect(liberty.received_message.message).to eq 'Need new insurance.OTHER'
      end
    end
  end
  
  describe '#accident_occured' do
    context 'driver is insured' do
      it 'sends a message from Insurance Company, to the car driver' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        jake = Person.new(name: 'Jake', insurance: liberty)
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: jake)
        peugeot207.accident_occured
        expect(jake.received_message).to eq Notification.new(liberty, jake, 'Your car had an accident. Do not worry, we are taking care already')
      end
    end

    context 'driver is not insured' do
      it 'sends message only if driver is insured' do
        jake = Person.new(name: 'Jake')
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: jake)
        expect{
          peugeot207.accident_occured
        }.to raise_error Car::NoInsuranceError, 'You do not have an insurance. Message sending aborted'
      end
    end
  end
end
