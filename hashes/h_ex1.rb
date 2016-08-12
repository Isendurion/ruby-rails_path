#Given a hash of family members, with keys as the title and an array of names as the values,
#use Ruby's built-in select method to gather only immediate family members' names into a new array.

family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
}

immediate_family = family.select {|k, | k == :sisters || k == :brothers}
p immediate_family.values.flatten

#Look at Ruby's merge method. Notice that it has two versions. What is the difference between merge and merge!?
#Write a program that uses both and illustrate the differences.

h1 = {'Robin' => 9, 'Jane' => 67}
h2 = {'Greg' => 33, 'Betty' => 29}

p h1.merge(h2) #gives new array h1 merged with h2
p h1 #no change
p h2 #no change

h1.merge!(h2) #adds h2 to h1

p h1 #changed
p h2 #no change

#Using some of Ruby's built-in Hash methods,
#write a program that loops through a hash and prints all of the keys.
#Then write a program that does the same thing except printing the values.
#Finally, write a program that prints both.

h3 = {messi: 90, lewandowski: 86, kapustka: 71, fabianski: 93}

h3.each_key {|k| puts "#{k}, "}
h3.each_value{|v| puts "#{v}, "}
h3.each_pair{|k, v| puts "#{k}: #{v}, "}

# wyciagnac z Hasha litery ktore powtarzaja sie wiecej niz 5 razy

h = {a: 10, k: 3, g: 6, b: 2}
h.each{|k, v| puts "#{k}: #{v}" if v > 5}


nh1 = { a: 1, b: 2 }
nh2 = { a: 3, b: 24, c: 4 }

p nh2[:a].is_a?(Array)

nh2.each{|k, v| nh2[k] = [v] unless nh2[k].is_a? Array}
p nh2

