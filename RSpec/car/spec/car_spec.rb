require 'spec_helper'

describe Car do
  describe '.new' do
    it 'creates new car with given name, brand, model and driver' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      expect(peugeot207).to be_a_kind_of Car
    end

    it 'creates car with speed set to 0' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      expect(peugeot207.speed).to eq 0
    end

    it 'creates car with a clutch not pressed' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      expect(peugeot207.clutch).to eq false
    end

    it 'creates car with lights turned off' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      allow(peugeot207.tail_lamps).to receive(:turn_off!)
      peugeot207.stop_engine
      expect(peugeot207.tail_lamps).to have_received(:turn_off!)
    end
  end

  describe '#show_car' do
    it 'shows car specification' do
    peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
    allow(peugeot207).to receive(:puts)
    peugeot207.show_car
    expect(peugeot207).to have_received(:puts).with("Name: Peugeot 207\nBrand: Peugeot\nModel: 207\nTransmission: 5-speed\n")
    end
  end

  describe '#start_engine' do
    let(:peugeot207) { Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))}

    context 'clutch is pressed' do
      before { peugeot207.clutch = true }

      it 'sets speed to 0' do
        peugeot207.start_engine
        expect(peugeot207.speed).to eq 0
      end

      it 'turns head lights on' do
        peugeot207.start_engine
        expect(peugeot207.head_lamps.is_turned_on).to eq true
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
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      peugeot207.stop_engine
      expect(peugeot207.speed).to eq 0
    end

    context 'it is not the case of emergency' do
      it 'turns the lights off' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
        peugeot207.lights.turn_off_lamps!(peugeot207.left_indicator, peugeot207.right_indicator)
        peugeot207.lights.turn_on_lamps!(peugeot207.head_lamps, peugeot207.tail_lamps, peugeot207.stop_lamps)
        peugeot207.stop_engine
        expect(peugeot207.head_lamps.is_turned_on).to eq false
        expect(peugeot207.tail_lamps.is_turned_on).to eq false
        expect(peugeot207.stop_lamps.is_turned_on).to eq false
        expect(peugeot207.left_indicator.is_turned_on).to eq false
        expect(peugeot207.right_indicator.is_turned_on).to eq false
      end
    end

    context 'it is the case of emergency' do
      it 'turns the lights off excluding emergency lights' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
        peugeot207.left_indicator.is_turned_on = true
        peugeot207.right_indicator.is_turned_on = true
        peugeot207.stop_engine
        expect(peugeot207.head_lamps.is_turned_on).to eq false
        expect(peugeot207.tail_lamps.is_turned_on).to eq false
        expect(peugeot207.stop_lamps.is_turned_on).to eq false
        expect(peugeot207.left_indicator.is_turned_on).to eq true
        expect(peugeot207.right_indicator.is_turned_on).to eq true
      end
    end
  end

  describe '#turn' do
    it 'turns the indicator on for given direction' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      peugeot207.turn('right')
      expect(peugeot207.right_indicator.is_turned_on).to eq true
    end

    it 'turns on the indicator only if proper direction is given' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      expect{
        peugeot207.turn('straight')
      }.to raise_error Car::WrongDirectionError, 'You can turn left or right only!'
    end
  end

  describe '#end_turn' do
    context 'it is not the case of emergency' do
      it 'turns indicators off' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
        peugeot207.turn('right')
        peugeot207.end_turn
        expect(peugeot207.left_indicator.is_turned_on).to eq false
        expect(peugeot207.right_indicator.is_turned_on).to eq false
      end
    end

    context 'it is the case of emergency' do
      it 'it does not turn indicators off' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
        peugeot207.left_indicator.turn_on!
        peugeot207.right_indicator.turn_on!
        expect{
          peugeot207.end_turn
        }.to raise_error Car::CaseOfEmergencyException, 'Warning! Hazard on the road. Do not turn emergency lights off!'
      end
    end
  end

  describe '#hit_the_brakes' do
    it 'turns the brake lights on' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      peugeot207.stop_lamps.turn_off!
      peugeot207.speed = 120
      peugeot207.hit_the_brakes(30)
      expect(peugeot207.stop_lamps.is_turned_on).to eq true
    end

    it 'sets speed to given value' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      peugeot207.speed = 120
      peugeot207.hit_the_brakes(30)
      expect(peugeot207.speed).to eq 30
    end
  end

  describe '#release_brakes' do
    it 'turns the brake_lights off' do
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      peugeot207.stop_lamps.turn_on!
      peugeot207.release_brakes
      expect(peugeot207.stop_lamps.is_turned_on).to eq false
    end
  end

  describe '#send_notification' do
    context 'receiver does not require keywords' do
      it 'sends message without keywords' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
        seat_ibiza = Car.new(name: 'Seat Ibiza', brand: 'Seat', model: 'Ibiza', driver: Person.new(name: 'Wayne'))
        peugeot207.send_notification(seat_ibiza, 'Do not break so unexpectedly')
        expect(seat_ibiza.received_message).to eq Notification.new(peugeot207, seat_ibiza, 'Do not break so unexpectedly.')
      end

      it 'sends message only when keywords are not required' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
        seat_ibiza = Car.new(name: 'Seat Ibiza', brand: 'Seat', model: 'Ibiza', driver: Person.new(name: 'Wayne'), is_keyword_required: true)
        expect{
          peugeot207.send_notification(seat_ibiza, 'Do not break so unexpectedly.')
        }.to raise_error Car::KeywordRequiredError, 'Keyword required. Sending aborted'
      end
    end

    context 'receiver requires keywords' do
      it 'sends message with keywords' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake', insurance: liberty))
        expect(peugeot207.send_notification(liberty, 'Accident occured. Send car carrier', 'ACCIDENT')).to be_a_kind_of Notification
      end

      it 'sends message with accident pattern' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake', insurance: liberty))
        peugeot207.send_notification(liberty, 'Accident occured. Send car carrier', liberty.notification_keywords[:accident])
        expect(liberty.received_message.message).to eq 'Accident occured. Send car carrier.ACCIDENT'
      end

      it 'sends message with other pattern' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake', insurance: liberty))
        peugeot207.send_notification(liberty, 'Need new insurance', liberty.notification_keywords[:other])
        expect(liberty.received_message.message).to eq 'Need new insurance.OTHER'
      end
    end
  end
  
  describe '#accident_occured' do
    context 'driver is insured' do
      it 'sends a message from Insurance Company, to the car driver' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake', insurance: liberty))
        peugeot207.accident_occured
        expect(peugeot207.driver.received_message).to eq Notification.new(liberty, peugeot207.driver, 'Your car had an accident. Do not worry, we are taking care already')
      end
    end

    context 'driver is not insured' do
      it 'sends message only if driver is insured' do
        peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
        expect{
          peugeot207.accident_occured
        }.to raise_error Car::NoInsuranceError, 'You do not have an insurance. Message sending aborted'
      end
    end
  end
end
