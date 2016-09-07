class Lamp < Struct.new(:name, :is_turned_on) do
  def turn_off!
    switch(state: false)
  end

  def turn_on!
    switch(state: true)
  end

  private
  def switch(state:)
    self.is_turned_on = state
  end
end
end

