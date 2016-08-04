#Use fib to create the following array: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
#Notice that these are the first ten numbers in the Fibonocci sequence
#and each number equal the sum of the prior two numbers.
fib = [0, 1]

while fib.length < 10
  fib << fib[-2] + fib[-1]
end

p fib

#Use the blockbusters array to construct the following hash:
#{"will smith" => "i am legend", "brad pitt" => "fight club", "frodo" => "the hobbit"}
blockbusters = [['will smith', 'i am legend'], ['brad pitt', 'fight club'], ['frodo', 'the hobbit']]

hash = {}
blockbusters.each do |actor, movie|
  hash[actor] = movie
end
p hash

#Use nums and letters to construct the following array:
#[[1, "a"], [1, "b"], [1, "c"], [2, "a"], [2, "b"], [2, "c"], [3, "a"], [3, "b"], [3, "c"]]
nums = [1, 2, 3]
letters = ['a', 'b', 'c']

p nums.product(letters)

#Return the physical costs associated with hockey in the following sports hash.

    sports = {
    :hockey => {
        :benefits => [:fun, :teamwork],
        :costs => {
            :financial => ["mad money"],
            :physical => [:concussions]
        }
    }
}

p sports[:hockey][:costs][:physical]


#Use the cities hash to print out the following strings:
#"santa_cruz is chill"
#"new_york is intense"
cities = {
    santa_cruz: "chill",
    new_york: "intense"
}

puts "#{cities.key("chill")} is #{cities[:santa_cruz]}"
puts "#{cities.key("intense")} is #{cities[:new_york]}"

#Convert some_hash to [[:a, 123], [:b, 456]]
some_hash = {a: 123, b: 456}
p some_hash.to_a

ary = []
some_hash.each_pair do |letter, number|
  ary << Array[letter, number]
end
p ary
