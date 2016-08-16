# ||= jesli false lub nil, przypisz wartosc

# Using ark array (['cat', 'dog', 'pig', 'goat']),
# create a new array in which every second element is uppercased and backwards.

ark = %w(cat dog pig goat)

result = ark.map.with_index do |animal, index|
  index % 2 == 1 ? animal.upcase.reverse : animal
end

p result

# Print the elements at indices 1, 3, 5, 7, etc. on separate lines. You should make use of Enumerable#each_with_index

ary = %w(a v t s e z w g v h s t p)
help = []
ary.each_with_index do |el, idx|
    if idx % 2 == 1
      help << el
      else print "#{el} "
  end
end
puts; puts help.join(' ')

# Return the odd numbers from a list of integers. You should make use of Enumerable#select

r = (1..35)
p r.select{|num| num % 2 == 1}

# Return the first number from an Array that is less than a particular number - 'limit.'
# You should make use of Enumerable#find

nums = [91, 83, 69, 98, 76, 12, 32, 22, 38, 68, 23, 74, 22, 82]
limit = 68

p nums.find{|num| num < limit}

# Take an Array of Strings and return a new Array with an exclamation point appended to each String.
# You should make use of Enumerable#map

p ary.map{|item| item+'!'}

# Calculate the sum of an Array of numbers. You should make use of Enumerable#reduce

p nums.reduce(:+)

# Reorganize an Array of the elements into groups of 3, and then sort each group alphabetically.
# You should make use of Enumerable#each_slice

animals = %w(cat dog pig goat bird elephant jaguar fly yeti bear frog deer)
animals.each_slice(3){|threes| p threes.sort}
