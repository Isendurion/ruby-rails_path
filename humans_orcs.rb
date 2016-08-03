class Creature
  attr_accessor :name, :age, :hp, :power, :fury

  def initialize(name, age, hp, power, fury = false)
    @name = name
    @age = age
    @hp = hp
    @power = power
    @fury = fury
  end

  def speak
    puts 'Welcome stranger!'
  end

  def attack(opponent)
    rand_atk = Random.new
    attack = rand_atk.rand((@power-5)..(@power+5))
    puts "#{opponent.name} hp: #{opponent.hp} is attacked by #{name} with #{attack}"
    opponent.hp -= attack
  end

  def fury
    if @fury == false
      puts "#{@name} gained FURY!"
      @power += (3 * @power)
    end
    @fury = true
  end

  def death
    @hp = 0
    puts "#{@name}: Uaghhhh..."
  end

  def show_parameters
    puts "Name: #{@name}\n Age: #{@age}\n HP: #{@hp}\n PO: #{@power}"
  end

end

class Race < Creature
end

class Human < Race
  def speak
    super
    puts "I'm from proud, Human race"
  end
end

class Orc < Race
  def speak
     puts "Ag'ks solrrk!"
  end
end

conan = Human.new('Conan', 23, 100, 10)
garosh = Orc.new('Garosh', 39, 150, 15)

conan.speak
conan.show_parameters
garosh.speak

while conan.hp || garosh.hp > 0
  conan.attack(garosh)
  if garosh.hp <= 0
    garosh.death
    break
  end
  garosh.attack(conan)
  conan.fury if conan.hp < 50
  if conan.hp <= 0
    conan.death
    break
  end
end

