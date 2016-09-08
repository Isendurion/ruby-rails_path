module Present
  def show_car
    puts "Name: #{name}\nBrand: #{brand}\nModel: #{model}\nTransmission: #{gearbox.transmission}-speed\n"
  end
end

class Car
  include(Present)
  extend Forwardable

  def_delegators :lights, :head, :tail, :brake, :left_indicator, :right_indicator
  def_delegator :lights, :head, :head_lamps
  def_delegator :lights, :tail, :tail_lamps
  def_delegator :lights, :brake, :stop_lamps
  def_delegator :driver, :name, :driver_name

  ClutchNotPressedError = Class.new(StandardError)
  CaseOfEmergencyException = Class.new(StandardError)
  NoInsuranceError = Class.new(StandardError)
  KeywordRequiredError = Class.new(StandardError)
  WrongDirectionError = Class.new(StandardError)

  attr_accessor :speed, :clutch, :lights, :received_message, :name, :brand, :model, :gearbox, :driver
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
    if clutch
      @speed = 0
      # head_lamps.turn_on!
      head.turn_on!
    else
      raise ClutchNotPressedError, 'Clutch is not pressed'
    end
  end

  def stop_engine
    @speed = 0
    if lights.emergency_lights_turned_on?
      lights.turn_off_lamps!(head_lamps, tail_lamps, stop_lamps)
    else
      lights.turn_off_lamps!(head_lamps, tail_lamps, stop_lamps, left_indicator, right_indicator)
    end
  end

  def turn(direction)

    if "#{direction}_indicator" == left_indicator.name
      left_indicator.turn_on!
    elsif "#{direction}_indicator" == right_indicator.name
      right_indicator.turn_on!
    else
      raise WrongDirectionError, 'You can turn left or right only!'
    end
  end

  def end_turn
    if lights.emergency_lights_turned_on?
      raise CaseOfEmergencyException, 'Warning! Hazard on the road. Do not turn emergency lights off!'
    else
      lights.turn_off_lamps!(left_indicator, right_indicator)
    end
  end

  def hit_the_brakes(new_speed)
    stop_lamps.turn_on!
    @speed = new_speed
  end

  def release_brakes
    stop_lamps.turn_off!
  end

  def send_notification(recipient, message, keyword = '')
    if recipient.is_keyword_required && keyword == ''
      raise KeywordRequiredError, 'Keyword required. Sending aborted'
    else
      recipient.received_message = Notification.new(self, recipient, "#{message}.#{keyword}")
    end
  end

  def accident_occured
    if driver.insurance != 'no insurance'
      recipient = @driver.insurance
      message = 'Accident occured. Send car carrier'
      keyword = @driver.insurance.notification_keywords[:accident]
      send_notification(recipient, message, keyword)
      driver.insurance.answer_message(driver)
    else
      raise NoInsuranceError, 'You do not have an insurance. Message sending aborted'
    end
  end
end
