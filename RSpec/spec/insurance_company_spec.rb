require 'spec_helper'

describe InsuranceCompany do
  describe '#send_notification' do
    context "received a message from driver's car" do
      it 'sends notification to the recipient' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        jake = Person.new(name: 'Jake', insurance: liberty)
        liberty.received_message = 'Hi there. How is my insurance?'
        text = 'Thank You for writing to us. We will response soon'
        liberty.send_notification(jake)
        expect(jake.received_message).to eq 'From: Liberty Insurance, to Jake: Thank You for writing to us. We will response soon'
      end
    end

    context 'accident message received' do
      it 'it sends notification about an accident' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        jake = Person.new(name: 'Jake', insurance: liberty)
        liberty.received_message = '[ACCIDENT]: 2 cars involved. Send a rescue car'
        liberty.send_notification(jake)
        expect(jake.received_message).to eq 'From: Liberty Insurance, to Jake: An accident occured. Do not worry we will take care'
      end
    end

    context 'no message received' do
      it 'sends notification only when message is recieved' do
        liberty = InsuranceCompany.new(name: 'Liberty Insurance')
        jake = Person.new(name: 'Jake', insurance: liberty)
        liberty.received_message = 'no messages received'
        expect{
          liberty.send_notification(jake)
        }.to raise_error InsuranceCompany::NoMessageReceivedError, 'No message received'
      end
    end
  end
end
