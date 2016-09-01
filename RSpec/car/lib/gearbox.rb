class Gearbox
  NUMBER_OF_DEFAULT_GEARS = 2

  IncorrectSpeedException = Class.new(StandardError)

  attr_accessor :car_speed, :is_clutch_pressed, :gear
  attr_reader :gears, :transmission

  def initialize(gears: OpenStruct.new(neutral: 0,
                                       reverse: 0..10,
                                       one: 0...20,
                                       two: 20...40,
                                       three: 40...60,
                                       four: 60...90,
                                       five: 90...140))
    @gears = gears
    @gear = @gears.neutral
  end

  private
  def set_number_of_gears
    @number_of_gears = gears.to_h.size
  end

  public
  def set_transmission
    set_number_of_gears
    @transmission = @number_of_gears - NUMBER_OF_DEFAULT_GEARS
  end

  def shift_gear(gear_range:, clutch_pressed:, speed:)
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
