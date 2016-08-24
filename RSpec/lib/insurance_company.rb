class InsuranceCompany
  NoMessageReceivedError = Class.new(StandardError)

  NOTIFICATION_KEYWORDS = {accident: 'ACCIDENT'}

  attr_accessor :name, :received_message, :notification_keywords

  def initialize(name:)
    @name = name
    @received_message = 'no messages received'
    @notification_keywords = NOTIFICATION_KEYWORDS
  end

  def send_notification(recipient)
    if @received_message.include?(NOTIFICATION_KEYWORDS[:accident])
      text = 'An accident occured. Do not worry we will take care'
    elsif @received_message == 'no messages received'
      raise NoMessageReceivedError, 'No message received'
    else text = 'Thank You for writing to us. We will response soon'
    end

    note = Notification.new(self, recipient, text)
    note.send_message
  end
end
