module Present
  def show_car
    puts "Name: #{self.name}\nBrand: #{self.brand}\nModel: #{self.model}\nTransmission: #{self.gearbox.set_transmission}-speed\n"
  end
end

class Car
  include(Present)

  ClutchNotPressedError = Class.new(StandardError)
  CaseOfEmergencyException = Class.new(StandardError)
  NoInsuranceError = Class.new(StandardError)
  KeywordRequiredError = Class.new(StandardError)
  WrongDirectionError = Class.new(StandardError)

  attr_accessor :speed, :gear, :clutch, :lights, :received_message, :name, :brand, :model, :gearbox, :driver
  attr_reader :is_keyword_required

  def initialize(name:, brand:, model:, driver:, is_keyword_required: false)
    @name = name
    @brand = brand
    @model = model
    @driver = driver
    @speed = 0
    @clutch = false
    @gearbox = Gearbox.new
    @lights = Lights.new
    @received_message = ''
    @is_keyword_required = is_keyword_required
  end

  def start_engine
    if @clutch
      @speed = 0
      @lights.head.change_lamp_state
    else
      raise ClutchNotPressedError, 'Clutch is not pressed'
    end
  end

  def stop_engine
    @speed = 0
    if @lights.emergency_lights_turned_on?
      @lights.change_lamps_state(lights.head, lights.tail, lights.brake, should_be_turned_on: false)
      @lights.change_lamps_state(lights.left_turn, lights.right_turn, should_be_turned_on: true)
    else
      @lights.change_lamps_state(:all, should_be_turned_on: false)
    end
  end

  def turn(direction)
    if "#{direction}_turn" == @lights.left_turn.name
      @lights.change_lamps_state(lights.left_turn, should_be_turned_on: true)
    elsif "#{direction}_turn" == lights.right_turn.name
      @lights.change_lamps_state(lights.right_turn, should_be_turned_on: true)
    else
      raise WrongDirectionError, 'You can turn left or right only!'
    end
  end

  def end_turn
    if @lights.emergency_lights_turned_on?
      raise CaseOfEmergencyException, 'Warning! Hazard on the road. Do not turn emergency lights off!'
    else
      @lights.change_lamps_state(lights.left_turn, lights.right_turn, should_be_turned_on: false)
    end
  end

  def hit_the_brakes(new_speed)
    @lights.change_lamps_state(lights.brake, should_be_turned_on: true)
    @speed = new_speed
  end

  def release_brakes
    @lights.brake.is_turned_on = false
  end

  def send_notification(recipient, message, keyword = '')
    if recipient.is_keyword_required && keyword == ''
      raise KeywordRequiredError, 'Keyword required. Sending aborted'
    else
      recipient.received_message = Notification.new(self, recipient, "#{message}.#{keyword}")
    end
  end

  def accident_occured
    if @driver.insurance != 'no insurance'
      recipient = @driver.insurance
      message = 'Accident occured. Send car carrier'
      keyword = @driver.insurance.notification_keywords[:accident]
      send_notification(recipient, message, keyword)
      @driver.insurance.answer_message(@driver)
    else
      raise NoInsuranceError, 'You do not have an insurance. Message sending aborted'
    end
  end
end
