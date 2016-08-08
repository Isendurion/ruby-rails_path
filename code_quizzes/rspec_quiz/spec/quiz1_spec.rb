#Write code to make the following tests pass:

require "quiz1"

describe "#word_count" do
  it "returns number of words in a string" do
    string = "laughter, it's free"
    expect(word_count(string)).to eq 3
  end

  it "returns 0 for empty string" do
    expect(word_count("")).to eq 0
  end
end

describe "#average_word_length" do
  it "returns average word length" do
    string = "i wish that i was cool"
    expect(average_word_length(string)).to be_within(0.01).of 2.83
  end

  it "returns nil for empty string" do
    expect(average_word_length("")).to be_nil
  end
end

describe "#palindrome?" do
  it "returns true if string is a palindrome" do
    expect("racecar".palindrome?).to be true
  end

  it "returns false if string is not a palindrome" do
    expect("poochie".palindrome?).to be false
  end
end

describe "#vowels" do
  it "returns array of words with vowels" do
    str = "24 hour roadside resistance"
    expected = %w|hour roadside resistance|
    expect(vowels(str)).to eq expected
  end
end

describe "#start_with_c?" do
  it "returns true if all words begin with 'c'" do
    str = "cool captain crunch cap"
    expect(start_with_c?(str)).to be true
  end

  it "returns false if all words don't begin with 'c'" do
    str = "crazy cat dude"
    expect(start_with_c?(str)).to be false
  end
end

describe "#strip_whitespace" do
  it "removes all whitespace" do
    str = "   three ninjas attack!  "
    expected = "threeninjasattack!"
    expect(str.strip_whitespace).to eq expected
  end
end

describe "#titlecase" do
  it "capitalizes the first letter of every word" do
    str = "the grand Gala party"
    expected = "The Grand Gala Party"
    expect(str.titlecase).to eq expected
  end
end

describe "#delete_last" do
  it "removes last n elements from string" do
    str = "hello"
    expect(str.delete_last(2)).to eq "hel"
  end

  it "mutates self in place" do
    str = "blah"
    expect(str.delete_last(1)).to equal str.replace "bla"
  end
end

describe "#date_convertible?" do
  it "returns true if can be converted to date" do
    str = "20120120"
    expect(str.date_convertible?).to be true
  end

  it "returns false if self cannot be converted to a date" do
    str = "blah"
    expect(str.date_convertible?).to be false
  end
end #not finished
