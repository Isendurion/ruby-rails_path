class Gearbox
extend Forwardable

def_delegator :gears, :neutral, :neutral_gear
def_delegator :gears, :reverse, :reverse_gear
def_delegator :gears, :one, :gear_one
def_delegator :gears, :two, :gear_two
def_delegator :gears, :three, :gear_three
def_delegator :gears, :four, :gear_four
def_delegator :gears, :five, :gear_five

  IncorrectSpeedException = Class.new(StandardError)

  attr_accessor :gear, :transmission, :gears

  def initialize(transmission: 5, gears: OpenStruct.new(neutral: 0,
                                                        reverse: 0..10,
                                                        one: 0...20,
                                                        two: 20...40,
                                                        three: 40...60,
                                                        four: 60...90,
                                                        five: 90...140))
    @gears = gears
    @gear = @gears.neutral
    @transmission = transmission
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
    @gear = neutral_gear
  end

  def shift_reverse_gear(speed)
    if speed == 0
      @gear = reverse_gear
    else
      raise IncorrectSpeedException, 'Incorrect speed to reverse. Stop the car first'
    end
  end
end
