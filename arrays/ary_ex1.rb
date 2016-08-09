#Below we have given you an array and a number. Write a program that checks to see if the number appears in the array.

arr = [1, 3, 5, 7, 9, 11]
number = 3

puts arr.include?(number)

#print example word
arr = [%w(test hello world), ["example", "mem"]]

puts arr.last.first

#Write a program that iterates over an array and builds a new array that is the result of incrementing each value
#in the original array by a value of 2. You should have two arrays at the end of this program,
#The original array and the new array you've created. Print both arrays to the screen using the p method instead of puts.

arr = [1,2,3]

arr2 = arr.map {|x| x+2}
p arr
p arr2

#end


# wyciągnąc ze str najczesciej powtarzajacy sie znak

str = 'calculates average'
str.gsub(' ', '').split('').each_with_object(my_hash = Hash.new(0)) do |char, h|
  h[char] += 1
end
p my_hash.sort.first.first

# wyciagnac z Hasha litery ktore powtarzaja sie wiecej niz 5 razy

h = {a: 10, k: 3, g: 6, b: 2}
result = []
h.map{|k, v| result << k if v > 5}

# stworzyc yield, ktory iteruje nieskonczenie i zwraca liczbe podzielna przez 11 (do zamiany z inna)
# stworzyc klase config z dowolnymi parametrami (adres, mail itp) przekazac parametry yieldem
# yield z tablicy do bloku i wyswietlic nazwe



