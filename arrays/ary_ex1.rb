#Below we have given you an array and a number. Write a program that checks to see if the number appears in the array.

arr = [1, 3, 5, 7, 9, 11]
number = 3

puts arr.include?(number)

#print example word
arr = [%w(test hello world), ["example", "mem"]]

puts arr.last.first

# Write a program that iterates over an array and builds a new array that is the result of incrementing each value
# in the original array by a value of 2. You should have two arrays at the end of this program,
# The original array and the new array you've created. Print both arrays to the screen using the p method instead of puts.

arr = [1,2,3]

arr2 = arr.map {|x| x+2}
p arr
p arr2

#end


# wyciągnąc ze str najczesciej powtarzajacy sie znak

str = 'calculates average'
my_hash = str.split('').each_with_object(Hash.new(0)){|char, h| h[char] += 1}
p my_hash.sort_by(&:last).reverse.first.first

# use inject and reduce to calculate average and max from an array

arr = [1, 3, 5, 7, 9, 11, 4, 53, 26, 19, 44]

puts max = arr.inject{|mem, num| mem < num ? num : mem}
puts avr = arr.reduce(:+) / arr.length

# wyciagnac z tekstu adres email skladajacy sie z wielu '.' '-' i '+'
str = "s.kieloch@selleo.com
test.test.test@test.etste.asdf
test-test.test@test-test.com.pl
test-test.test+alias@test-test.com.pl
nope: .test-test.test+alias@test-test.com.pl
nope: -.test-test.test+alias@test-test.com.pl
nope: +-.test-test.test+alias@test-test.com.pl
nope: test-test.test+alias@test-test.com.pl.
nope: test-test.test+alias@test-test.com.pl+
nope: test-test.test+alias@test-test.com.pl-"

mail = '+-.test-test.test+alias@test-test.com.pl'
regex = /[^\s\d\W]\S+@\S+[^\s\d\W]/

# zwracac czy mail jest prawidlowy po porownaniu z regexpem

p regex.match(mail).to_s == mail
