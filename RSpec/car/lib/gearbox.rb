class Gearbox

  IncorrectSpeedException = Class.new(StandardError)

  attr_accessor :car_speed, :is_clutch_pressed, :gear
  attr_reader :gears, :transmission

  def initialize(gears: Gears.new)
    @gears = gears
    @gear = @gears.neutral
    @transmission = @gears.number_of_gears - @gears.number_of_default_gears
  end

  def shift_gear(gear_range, clutch_pressed, speed)
    if clutch_pressed
      if gear_range.include?(speed)
        @gear = gear_range
        gear_range.max
      else raise IncorrectSpeedException, 'Incorrect speed to shift this gear. Adjust speed'
      end
    else raise Car::ClutchNotPressedError, 'Clutch is not pressed'
    end
  end

  def shift_neutral_gear
    @gear = @gears.neutral
  end

  def shift_reverse_gear(speed)
    if speed == 0
      @gear = @gears.reverse
    else
      raise IncorrectSpeedException, 'Incorrect speed to reverse. Stop the car first'
    end
  end
end
