class CarPresentation
  def initialize(name, brand, model, transmission)
    @name = name
    @brand = brand
    @model = model
    @transmission = transmission
  end
  def show_car
    "Name: #{@name}\nBrand: #{@brand}\nModel: #{@model}\nTransmission: #{@transmission}-speed"
  end
end
