class Car
  IncorrectSpeedException = Class.new(StandardError)
  GEARS = {neutral: (0..0), one: (0..20), two: (20..40), three: (40..60), four: (60..90), five: (90..140), reverse: (0..10)}
  # neutral, one, two, three, four, five, reverse

  attr_accessor :speed, :gear

  def initialize(name:, brand:, model:)
    @name = name
    @brand = brand
    @model = model
    @speed = 0
    @gear = GEARS.key(0..0)
  end

  def show_car
    "Name: #{@name}\nBrand: #{@brand}\nModel: #{@model}"
  end

  def start_engine
    @speed = 0
  end

  def stop_engine
    @speed = 0
  end

  def gear_1
    if GEARS[:one].include?(@speed)
      @speed = GEARS[:one].max
      @gear = GEARS.key(0..20)
    else
      raise IncorrectSpeedException, "Incorrect speed to switch to gear #{GEARS.key(0..20).to_s}. Adjust speed"
    end
  end

  def gear_2
    if GEARS[:two].include?(@speed)
      @speed = GEARS[:two].max
      @gear = GEARS.key(20..40)
    else
      raise IncorrectSpeedException, "Incorrect speed to switch to gear #{GEARS.key(20..40).to_s}. Adjust speed"
    end
  end

  def gear_3
    if GEARS[:three].include?(@speed)
      @speed = GEARS[:three].max
      @gear = GEARS.key(40..60)
    else
      raise IncorrectSpeedException, "Incorrect speed to switch to gear #{GEARS.key(40..60).to_s}. Adjust speed"
    end
  end

  def gear_4
    if GEARS[:four].include?(@speed)
      @speed = GEARS[:four].max
      @gear = GEARS.key(60..90)
    else
      raise IncorrectSpeedException, "Incorrect speed to switch to gear #{GEARS.key(60..90).to_s}. Adjust speed"
    end
  end

  def gear_5
    if GEARS[:five].include?(@speed)
      @speed = GEARS[:five].max
      @gear = GEARS.key(90..140)
    else
      raise IncorrectSpeedException, "Incorrect speed to switch to gear #{GEARS.key(90..140).to_s}. Adjust speed"
    end
  end

  def gear_neutral
    @gear = GEARS.key(0..0)
  end

  def gear_reverse
    if @speed != 0
      raise IncorrectSpeedException, 'Incorrect speed. Stop the car'
    else @gear = GEARS.key(0..10)
    end
  end
end
