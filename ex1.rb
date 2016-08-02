module MoreAxisable
  def more_axises_than_two(axis)
    axis < 2 ? false : true
  end
end

class Vehicle
  attr_accessor :speed, :color, :year

  @@number_of_objects = 0

  def initialize(year, color)
    @year = year
    @color = color
    @speed = 0
    @@number_of_objects =+ 1
  end

  def speed_up(kph)
    @speed =+ kph
  end

  def self.show_number_of_objects
    puts @@number_of_objects
  end

end

class MyCar < Vehicle
  IS_DAMAGED = true

  def initialize(model, engine)
    @model = model
    @engine = engine
  end

  def describe
    puts "Your car (damaged? #{IS_DAMAGED}) is #{@color} #{@model} from #{@year} and it has speed #{speed} km/h"
  end
end

class MyTruck < Vehicle
  include MoreAxisable
  IS_DAMAGED = false

  def initialize(truck)
    @truck = truck
  end
end

arrow = MyCar.new('Peugeot', '1.4 TDI')

arrow.speed_up(30)
arrow.color = 'silver'
arrow.year = 2014
arrow.describe
Vehicle.show_number_of_objects

heavy = MyTruck.new('double')
puts heavy.more_axises_than_two(4)