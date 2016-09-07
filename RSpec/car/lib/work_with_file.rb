class WorkWithFile
  FileExistsError = Class.new(StandardError)

  def export(car)
    filename = "#{car.name.gsub(' ', '_')}.txt"
    if File.exist?(filename)
      raise FileExistsError, 'File with this name already exists. Change name'
    else
      File.new(filename, 'w')
      File.write(filename, "Name: #{car.name}\nBrand: #{car.brand}\nModel: #{car.model}\nTransmission: #{car.gearbox.transmission}-speed\n")
    end
  end
end
