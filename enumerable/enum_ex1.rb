# Add your own usage for enumerable - map / select / find / detect / collect

#map
p (1..10).map{|num| num * num}
#collect
p (1..10).collect{|num| num * num}

#find
proc = Proc.new do
  puts 'Nothing found, sorry'
end
p (1..10).find(proc){|num| num+6 == 18}
#detect
p (1..100).detect{|num| num % 3 == 0}

#select
p (1..10).select{|num| num * num}

# Build your custom function for mapping / selecting / finding / detecting / collecting

module Enumerable
  def my_map
    puts 'My new map method works as the old one!'
    result = []

    self.to_a.each do |elem|
      result << yield(elem)
    end
    result
  end

  def my_collect
    puts 'My new collect method works as the old one!'
    result = []

    self.to_a.each do |elem|
      result << yield(elem)
    end
    result
  end

  def my_find(ifnone = Proc.new{})
    puts 'My new find method works as the old one!'
    if block_given?
      self.to_a.each do |elem|
        if yield(elem)
          return elem
        end
      end
      ifnone.call
    else self.to_enum(:find)
    end
  end

  def my_detect(ifnone = Proc.new{})
    puts 'My new detect method works as the old one!'
    if block_given?
      self.to_a.each do |elem|
        if yield(elem)
          return elem
        end
      end
      ifnone.call
    else self.to_enum(:detect)
    end
  end

  def my_select
    puts 'My new select method works as the old one!'
    result = []

    if block_given?
      self.to_a.each do |elem|
        result << yield(elem)
      end
      result
    else
      self.to_enum(:select)
    end
  end
end

r = (1..10)
p r.my_map{|num| num*num}
p r.my_collect{|num| num*num}
p r.my_find
p r.my_detect
p r.my_select{|num| num * num}
