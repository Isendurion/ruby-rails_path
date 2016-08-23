class Car
  IncorrectSpeedException = Class.new(StandardError)
  ClutchNotPressedError = Class.new(StandardError)
  CaseOfEmergencyException = Class.new(StandardError)
  NoInsuranceError = Class.new(StandardError)

  GEARS = {neutral: (0..0), one: (0..20), two: (20..40), three: (40..60), four: (60..90), five: (90..140), reverse: (0..10)}
  DEFAULT_GEARS = 2

  attr_accessor :speed, :gear, :clutch, :lights

  def initialize(name:, brand:, model:, driver: Person.new(name: 'Robert'))
    @name = name
    @brand = brand
    @model = model
    @driver = driver
    @speed = 0
    @gear = GEARS.key(0..0)
    @clutch = false
    @lights = {head: false, tail: false, brake: false, left_turn: false, right_turn: false}
  end

  private
  def emergency_lights_turned_on?
    @lights[:left_turn] && @lights[:left_turn]
  end

  public
  def show_car
    "Name: #{@name}\nBrand: #{@brand}\nModel: #{@model}\nTransmission: #{GEARS.size - DEFAULT_GEARS}-speed"
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
    if @clutch
      if GEARS[gear].include?(@speed)
        @lights[:tail] = false
        @speed = GEARS[gear].max
        @gear = gear
      else
        raise IncorrectSpeedException, "Incorrect speed to shift gear #{gear}. Adjust speed"
      end
    else raise ClutchNotPressedError, 'Clutch is not pressed'
    end
  end

  def shift_neutral_gear
    @lights[:tail] = false
    @gear = GEARS.key(0..0)
  end

  def shift_reverse_gear
    if @speed != 0
      raise IncorrectSpeedException, 'Incorrect speed to reverse. Stop the car'
    else
      @gear = GEARS.key(0..10)
      @lights[:tail] = true
    end
  end

  def send_message(recipient, message)
    recipient.received_message = message
  end

  def accident_occured(guilty)
    if guilty.insurance == 'no insurance'
      raise NoInsuranceError, 'You do not have an insurance. Pay yourself!'
    else send_message(guilty.insurance, 'Accident occured. I am guilty')
    end
  end
end
