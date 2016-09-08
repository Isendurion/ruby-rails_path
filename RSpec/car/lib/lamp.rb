class Lamp < Struct.new(:name, :is_turned_on)
  def turn_off!
    self.is_turned_on = false
  end

  def turn_on!
    self.is_turned_on = true
  end
end

