class InsuranceCompany
  extend Forwardable

  def_delegator :received_message, :message, :message_text

  NoMessageReceivedError = Class.new(StandardError)

  NOTIFICATION_KEYWORDS = {accident: 'ACCIDENT', other: 'OTHER'}

  attr_accessor :name, :received_message, :notification_keywords
  attr_reader :is_keyword_required

  def initialize(name:, is_keyword_required: true)
    @name = name
    @received_message = ''
    @notification_keywords = NOTIFICATION_KEYWORDS
    @is_keyword_required = is_keyword_required
  end

  def answer_message(recipient)
    if @received_message == ''
      raise NoMessageReceivedError, 'No message received'
    elsif message_text.include?(notification_keywords[:other])
      message = 'Thank You for message. We will contact soon'
      recipient.received_message = Notification.new(self, recipient, message)
    elsif message_text.include?(notification_keywords[:accident])
      message = 'Your car had an accident. Do not worry, we are taking care already'
      recipient.received_message = Notification.new(self, recipient, message)
    end
    @received_message = ''
  end
end
