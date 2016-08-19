class Car
  IncorrectSpeedException = Class.new(StandardError)
  ClutchNotPressedError = Class.new(StandardError)

  GEARS = {neutral: (0..0), one: (0..20), two: (20..40), three: (40..60), four: (60..90), five: (90..140), reverse: (0..10)}
  LIGHTS = {head: false, tail: false, brake: false}

  attr_accessor :speed, :gear, :clutch, :lights

  def initialize(name:, brand:, model:)
    @name = name
    @brand = brand
    @model = model
    @speed = 0
    @gear = GEARS.key(0..0)
    @clutch = false
    @lights = LIGHTS
  end

  def show_car
    "Name: #{@name}\nBrand: #{@brand}\nModel: #{@model}"
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
    @lights[:head] = false
  end

  def hit_the_brakes(new_speed)
    @lights[:brake] = true
    @speed = new_speed
  end

  def release_brakes
    @lights[:brake] = false
  end

  def set_gear(gear)
    if @clutch
      if GEARS[gear].include?(@speed)
        @lights[:tail] = false
        @speed = GEARS[gear].max
        @gear = gear
      else
        raise IncorrectSpeedException, "Incorrect speed to switch to gear #{gear}. Adjust speed"
      end
    else raise ClutchNotPressedError, 'Clutch is not pressed'
    end
  end

  def set_neutral_gear
    @lights[:tail] = false
    @gear = GEARS.key(0..0)
  end

  def set_reverse_gear
    if @speed != 0
      raise IncorrectSpeedException, 'Incorrect speed to reverse. Stop the car'
    else
      @gear = GEARS.key(0..10)
      @lights[:tail] = true
    end
  end
end
