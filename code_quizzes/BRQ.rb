#Get the first letter from the string "Jaydakiss".
rapper = "Jaydakiss"
puts rapper[0]

#last letter
puts rapper[-1]

#Replace the "l" in the following string with "m":
word = "lace"
word[0] = 'm'
p word

#Convert every letter of "YoLo BrAh" to lowercase.
nice = "YoLo BrAh"
nice.downcase!
puts nice

#Concatenate the following strings:
first = "Beautiful "
second = "face tattoo"
puts first + second

#Integers have useful built-in methods too. Convert the number 5 to the string "5".
puts 5.to_s.class

#Get the first element of the lyric Array.
lyric = ["laughter", "it's", "free"]
puts lyric.first

#last element
puts lyric.last

#Add the string "open up shop" to the end of the ruff Array.
ruff = ["stop", "drop", "shut 'em down"]
ruff << "open up shop"
p ruff

#Define a method called funify() that takes an array as an argument and adds the word "fun" to the end of the array.
def funify(array)
  array << 'fun'
end

ary = ['I have']
funify(ary)
p ary

#Define a method called more_fun() that replaces the first element of an array with the word "FUN FUN".
def more_fun(array)
  array.first.replace('FUN FUN')
end

ary = %w(weird, park)
more_fun(ary)
p ary

#Iterate through first_names and populate result with the first_names and last name
#(result should be ["Hamburglar McDonald", "Grimace McDonald", "Ronald McDonald"] after the iteration).

result = []
first_names = ["Hamburglar", "Grimace", "Ronald"]
last_name = "McDonald"

first_names.each do |name|
  result << (name + " #{last_name}")
end

p result


#Add the :high_school key to the lebron hash with the value "St. Vincent-St. Mary High School".
lebron = {:sport => "basketball", :birthplace => "Akron"}
lebron[:high_school] = "St. Vincent-St. Mary High School"
p lebron

#Create an array of all students with test scores greater than 80. The result should be [["jon", 99], ["bill", 85]].
test_scores = [["jon", 99], ["sally", 65], ["bill", 85]]

result = []
test_scores.select do |student|
  (result << student) if student[1] > 80
end
p result

test_scores.select do |name, score|
  score > 80
end
