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
end

describe "#parse_params" do
  it "converts url query parameters to a Hash" do
    url = "https://something.com?days_ago=1000&sort_by=value"
    expected = {"days_ago"=>"1000", "sort_by"=>"value"}
    expect(url.parse_params).to eq expected
  end

  it "returns nil if there are no query parameters" do
    url = "https://something.com"
    expect(url.parse_params).to be_nil
  end
end

describe "#acronym?" do
  it "returns true if word is an acronym" do
    words = "what you see is what you get"
    expect(words.acronym?("wysiwyg")).to be true
  end

  it "returns false if word is not an acronym" do
    words = "your paper has way too many acronyms"
    expect(words.acronym?("blah")).to be false
  end
end

describe "#alliteration?" do
  it "returns true if words start with same letter" do
    words = "crazy cows consume crack"
    expect(words.alliteration?).to be true
  end

  it "returns false if words start with different letters" do
      words = "sky high stacks"
    expect(words.alliteration?).to be false
  end
end

describe "#to_money" do
  it "converts float to money format" do
    expect(12.991.to_money).to eq '$12.99'
  end

  it "correctly rounds zeros" do
    expect(9.0.to_money).to eq '$9.00'
  end
end

describe "#numeric?" do
  it "returns true if string can be converted to Float" do
    expect("12.48".numeric?).to be true
  end

  it "returns false if string cannot be converted to Float" do
    expect("blah".numeric?).to be false
  end
end

describe "#concat" do
  it "concatenates two integers" do
    expect(42.concat(99)).to eq 4299
  end
end

describe "#insert_multiple" do
  it "inserts multiple strings" do
    input = { 3=>"<b>", 6=>"</b>" }
    str = "aaabbbccc"
    expected = "aaa<b>bbb</b>ccc"
    expect(str.insert_multiple(input)).to eq expected
  end
end
