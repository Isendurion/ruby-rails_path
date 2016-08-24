Notification = Struct.new(:sender, :recipient, :message) do
  def send_message
    recipient.received_message = "From: #{sender.name}, to #{recipient.name}: #{message}"
  end
end

