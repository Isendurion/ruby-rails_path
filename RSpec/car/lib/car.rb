class Car
  IncorrectSpeedException = Class.new(StandardError)
  ClutchNotPressedError = Class.new(StandardError)
  CaseOfEmergencyException = Class.new(StandardError)
  NoInsuranceError = Class.new(StandardError)
  KeywordRequiredError = Class.new(StandardError)

  attr_accessor :speed, :gear, :clutch, :lights, :received_message
  attr_reader :is_keyword_required, :gearbox

  def initialize(name:, brand:, model:, driver: Person.new(name: 'Robert'), is_keyword_required: false)
    @name = name
    @brand = brand
    @model = model
    @driver = driver
    @speed = 0
    @clutch = false
    @gearbox = Gearbox.new(@clutch, @speed)
    @lights = {head: false, tail: false, brake: false, left_turn: false, right_turn: false}
    @received_message = ''
    @is_keyword_required = is_keyword_required
  end

  private
  def emergency_lights_turned_on?
    @lights[:left_turn] && @lights[:left_turn]
  end

  def send_speed_to_the_gearbox
    gearbox.car_speed = @speed
  end

  public
  def show_car
    CarPresentation.new(@name, @brand, @model, @gearbox.transmission).show_car
  end

  def start_engine
    if @clutch
      @speed = 0
      @lights[:head] = true
    else raise ClutchNotPressedError, 'Clutch is not pressed'
    end
  end

  def stop_engine
    @speed = 0
    if emergency_lights_turned_on?
      @lights = {head: false, tail: false, brake: false, left_turn: true, right_turn: true}
    else
      @lights.each_key{|k| @lights[k] = false}
    end
  end

  def turn(direction)
    @lights["#{direction}_turn".to_sym] = true
  end

  def end_turn
    if emergency_lights_turned_on?
      raise CaseOfEmergencyException, 'Warning! Hazard on the road. Do not turn emergency lights off!'
    else
      @lights[:left_turn] = false
      @lights[:right_turn] = false
    end
  end

  def turn_on_the_turn_lights
    @lights[:left_turn] = true
    @lights[:right_turn] = true
  end

  def turn_off_the_turn_lights
    @lights[:left_turn] = false
    @lights[:right_turn] = false
  end

  def hit_the_brakes(new_speed)
    @lights[:brake] = true
    @speed = new_speed
  end

  def release_brakes
    @lights[:brake] = false
  end

  def shift_gear(gear)
    send_speed_to_the_gearbox
    @lights[:tail] = false
    gearbox.shift_gear(gear)
  end

  def shift_neutral_gear
    @lights[:tail] = false
    @gearbox.gear = @gearbox.gears.key(0..0)
  end

  def shift_reverse_gear
    if @speed != 0
      raise IncorrectSpeedException, 'Incorrect speed to reverse. Stop the car'
    else
      @gearbox.gear = @gearbox.gears.key(0..10)
      @lights[:tail] = true
    end
  end

  def send_notification(recipient, message, keyword = '')
    if recipient.is_keyword_required && keyword == ''
      raise KeywordRequiredError, 'Keyword required. Sending aborted'
    else recipient.received_message = Notification.new(self, recipient, "#{message}.#{keyword}")
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
