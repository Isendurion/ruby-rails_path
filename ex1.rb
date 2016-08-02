class Vehicle
  attr_accessor :speed, :color, :year

  def initialize(year, color)
    @year = year
    @color = color
    @speed = 0
  end

  def speed_up(kph)
    @speed =+ kph
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