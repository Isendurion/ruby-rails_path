class CarDataFile
  extend Forwardable

  def_delegator :car, :name, :car_name
  def_delegator :car, :brand, :car_brand
  def_delegator :car, :model, :car_model
  def_delegator :car, :driver_name, :car_driver_name

  attr_accessor :car, :car_array

  def initialize(car)
    @car = car
  end

  def export
    filename = "#{car.name.gsub(' ', '_')}.txt"
    File.new(filename, 'w')
    File.write(filename, "Name: #{car.name}\nBrand: #{car.brand}\nModel: #{car.model}\nTransmission: #{car.gearbox.transmission}-speed\n")
  end

  def import(filename)
    @car_array = []
    file = File.open("../car/#{filename}", 'r')
    # number_of_lines = File.foreach(file).count
    @car = Car.new(name: '', brand: '', model: '', driver: Person.new(name: ''))
    car_parameters = file.map{|line| line.match(/\:\s(.*)/).to_a.last}
    car.name = car_parameters[0]
    car.brand = car_parameters[1]
    car.model = car_parameters[2]
    car.driver.name = car_parameters[3]
    car_array << car
  end
end
