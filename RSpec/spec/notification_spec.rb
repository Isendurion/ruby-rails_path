require 'spec_helper'

describe Notification do
  describe '#send_message' do
    it 'sends a message to the recipient' do
      liberty = InsuranceCompany.new(name: 'Liberty Insurance')
      jake = Person.new(name: 'Jake', insurance: liberty)
      note = Notification.new(liberty, jake, 'An accident occured. Do not worry we will take care')
      note.send_message
      expect(note.recipient.received_message).to eq 'From: Liberty Insurance, to Jake: An accident occured. Do not worry we will take care'
    end
  end
end
