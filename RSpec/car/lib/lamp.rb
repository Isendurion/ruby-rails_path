Lamp = Struct.new(:name, :is_turned_on) do
  def switch(state:)
    self.is_turned_on = state
  end
end
