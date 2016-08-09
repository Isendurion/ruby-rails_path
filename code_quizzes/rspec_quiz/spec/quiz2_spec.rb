#Write code to make the following tests pass:

require "quiz2"

describe "#has_string?" do
  it "returns true if self has a string" do
    arr = [:bob, "the", 42]
    expect(arr.has_string?).to eq true
  end

  it "returns false if self doesn't have a string" do
    arr = [:shut, :em, :down]
    expect(arr.has_string?).to eq false
  end
end

describe "#sort_by_length" do
  it "orders words from smallest to largest" do
    arr = %w|this is the story of a girl|
    expected = %w|a is of the girl this story|
    expect(arr.sort_by_length).to eq expected
  end
end

describe "#mean" do
  it "calculates average" do
    arr = [1, 2, 3, 4]
    expect(arr.mean).to eq 2.5
  end
end
