require 'spec_helper'

describe InsuranceCompany do
  describe '#answer_message' do
    context 'recieved message from the car' do
      it 'sends answer apropriate to keyword ACCIDENT' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        jake = Person.new(name: 'Jake', insurance: liberty)
        liberty.received_message = Notification.new(liberty, 'Need new insurance', liberty.notification_keywords[:accident])
        liberty.answer_message(jake)
        expect(jake.received_message).to eq Notification.new(liberty, jake, 'Your car had an accident. Do not worry, we are taking care already')
      end

      it 'sends answer apropriate to keyword OTHER' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        jake = Person.new(name: 'Jake', insurance: liberty)
        liberty.received_message = Notification.new(liberty, 'Need new insurance', liberty.notification_keywords[:other])
        liberty.answer_message(jake)
        expect(jake.received_message).to eq Notification.new(liberty, jake, 'Thank You for message. We will contact soon')
      end

      it 'erases received message' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        jake = Person.new(name: 'Jake', insurance: liberty)
        liberty.received_message = Notification.new(liberty, 'Need new insurance', liberty.notification_keywords[:other])
        liberty.answer_message(jake)
        expect(liberty.received_message).to eq ''
      end
    end

    context 'no message received' do
      it 'sends answer only if message is received' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        jake = Person.new(name: 'Jake', insurance: liberty)
        liberty.received_message = ''
        expect{
          liberty.answer_message(jake)
        }.to raise_error InsuranceCompany::NoMessageReceivedError, 'No message received'
      end
    end
  end
end
