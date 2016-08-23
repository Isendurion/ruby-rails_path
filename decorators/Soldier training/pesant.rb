class Pesant
  attr_accessor :strength, :weapon, :action

  def initialize
    @strength = 20
    @weapon = 'Pitchfork'
    @action = 'flee'
  end

  def do_when_attacked
    "I should #{@action}"
  end
end
