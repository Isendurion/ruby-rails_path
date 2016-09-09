# require 'forwardable'
# require 'ostruct'
# require_relative 'car'
# require_relative 'lights'
# require_relative 'lamp'
# require_relative 'gearbox'
# require_relative 'person'

class CarDataFile
  extend Forwardable

  def_delegator :car, :name, :car_name
  def_delegator :car, :brand, :car_brand
  def_delegator :car, :model, :car_model
  def_delegator :car, :driver_name, :car_driver_name

  attr_accessor :car, :imported_cars

  def initialize(car)
    @car = car
  end

  def export
    filename = "#{car.name.gsub(' ', '_')}.txt"
    File.new(filename, 'w')
    File.write(filename, "Name: #{car.name}\nBrand: #{car.brand}\nModel: #{car.model}\nTransmission: #{car.gearbox.transmission}-speed\n")
  end

  def import(filename)
    @imported_cars = []
    file = File.open("/Users/dkulpa/projects/ruby_txt/RSpec/car/database/#{filename}", 'r')
    car_parameters = file.map{|line| search_for_matches(/\:\s(.*)/, line)}
    number_of_lines_in_file = File.foreach(file).count

    current_line = 0
    (number_of_lines_in_file/4).times do
      @car = Car.new(name: '', brand: '', model: '', driver: Person.new(name: ''))
      car.name = car_parameters[current_line]
      car.brand = car_parameters[current_line+1]
      car.model = car_parameters[current_line+2]
      car.driver.name = car_parameters[current_line+3]
      @imported_cars << car
      current_line += 4
    end
  end

  private
  def search_for_matches(pattern, string)
    string.match(pattern).to_a.last
  end
end

# car_data_file = CarDataFile.new('')
# car_data_file.import('Seat_Ibiza.txt')
# car_data_file.imported_cars.each{|car| p car}
