class Gears
  attr_accessor :one, :two, :three, :four, :five, :rest
  attr_reader :neutral, :reverse, :number_of_gears, :number_of_default_gears

  def initialize(neutral: 0,
             reverse: 0..10,
             one: 0...20,
             two: 20...40,
             three: 40...60,
             four: 60...90,
             five: 90...140,
             **rest)
    @neutral = neutral
    @reverse = reverse
    @one = one
    @two = two
    @three = three
    @four = four
    @five = five
    rest.each_pair{|k, v| self.instance_variable_set "@"+k.to_s, v}
    @number_of_gears = self.instance_variables.size
    @number_of_default_gears = 2
  end
end

p Gears.new.number_of_default_gears
