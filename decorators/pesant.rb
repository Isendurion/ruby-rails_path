class Pesant
  attr_accessor :strength, :weapon

  def initialize(strength, weapon)
    @strength = strength
    @weapon = weapon
  end

  def if_they_attack_me(action)
    "I should #{action}"
  end
end

class Warrior
  def initialize(person)
    @person = person
  end

  def strength
    @person.strength + 20
  end

  def weapon
    @person.weapon = 'Sword'
  end

  def gain_confidence
    @person.if_they_attack_me("fight for the King!")
  end
end

mike = Pesant.new(20, 'Pitchfork')
warrior_mike = Warrior.new(mike)

puts mike.if_they_attack_me("flee")
puts mike.strength
puts mike.weapon
puts
puts warrior_mike.gain_confidence
puts warrior_mike.strength
puts warrior_mike.weapon
