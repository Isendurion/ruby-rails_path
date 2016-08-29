class Gearbox
  DEFAULT_GEARS = {neutral: (0..0),
             reverse: (0..10)}

  IncorrectSpeedException = Class.new(StandardError)

  attr_accessor :car_speed, :is_clutch_pressed, :gear
  attr_reader :gears, :transmission

  def initialize(is_clutch_pressed, car_speed, gears = {one:    (0...20),
                                                        two:    (20...40),
                                                        three:  (40...60),
                                                        four:   (60...90),
                                                        five:   (90..140)})
    @is_clutch_pressed = is_clutch_pressed
    @car_speed = car_speed
    @gears = gears.merge(DEFAULT_GEARS)
    @gear = @gears.key(0..0)
    @transmission = @gears.size - DEFAULT_GEARS.size
  end

  def shift_gear(gear_range)
    if @is_clutch_pressed
      if gear_range.include?(@car_speed)
        @gear = @gears.key(gear_range)
        @car_speed = gear_range.max
      else raise IncorrectSpeedException, "Incorrect speed to shift gear #{@gears.key(gear_range)}. Adjust speed"
      end
    else raise Car::ClutchNotPressedError, 'Clutch is not pressed'
    end
  end
end
