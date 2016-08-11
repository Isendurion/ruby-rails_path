# stworzyc yield, ktory iteruje nieskonczenie i zwraca liczbe podzielna przez 11 (do zamiany z inna)

def div_by(num)
  range = (1..1000)
  range.each do |digit|
    yield(digit) if digit % num == 0
    break if digit == 120
  end
end

div_by(13) do |digit|
  print "#{digit} | "
end


def ending_with_a
  words = %w(ala mam kota blabla test)
  words.each do |word|
    yield [word, 1] if word.match(/.*a$/)
  end
end

ending_with_a do |word, number|
  p word
  p "number: #{number}"
end


# stworzyc klase config z dowolnymi parametrami (adres, mail itp) przekazac parametry yieldem

class Config
  attr_accessor :name, :mail, :address
  def initialize
    @name = ''
    @mail = ''
    @address = ''
  end

  def set_vars
    yield self
  end

  def show_vars
    puts "#{@name}, #{@mail}, #{@address}"
  end

  def my_value=(new_value)
    @my_value = new_value
  end
end



cf = Config.new

cf.my_value = '1234'
cf.set_vars do |config|
  puts "let's change variables"
  config.name = 'Jane'
  config.mail = 'jane@rc.com'
  config.address = 'Sesam street'
end

cf.show_vars
