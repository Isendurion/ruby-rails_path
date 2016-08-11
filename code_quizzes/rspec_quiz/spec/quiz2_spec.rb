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

describe "#unzip" do
  it "deconstructs nested array" do
    nums = [1, 2, 3]
    lets = %w|a b c|
    zipped = nums.zip(lets)
    expected = [["a", "b", "c"], [1, 2, 3]]
    expect(zipped.unzip).to eq expected
  end
end

describe "#hashify" do
  it "converts to hash" do
    arr = [:a, :b, :c, :d]
    expected = {a: :b, c: :d}
    expect(arr.hashify).to eq expected
  end
end

describe "#super_compact" do
  it "removes nil and empty elements" do
    arr = [:bob, "", nil, [], "joe"]
    expected = [:bob, "joe"]
    expect(arr.super_compact).to eq expected
  end
end

describe "#tight_zip" do
  it "zips arrays of unequal length" do
    a = [1, 2, 3, 4]
    b = %w|a b|
    expected = [1, "a", 2, "b", 3, 4]
    expect(a.tight_zip(b)).to eq expected
  end
end

describe "#mode" do
  it "returns most common element" do
    arr = %w|a b dog a b b|
    expect(arr.mode).to eq "b"
  end
end

describe "#first_duplicate" do
  it "returns first duplicate in an array" do
    arr = %w|b c d c a a a|
    expect(arr.first_duplicate).to eq "c"
  end
end

describe "#symbolize" do
  it "creates an array of symbols" do
    arr = %w|b c d c a|
    expected = [:b, :c, :d, :c, :a]
    expect(arr.symbolize).to eq expected
  end
end

describe "#index_of_max" do
  it "returns index of largest array element" do
    arr = [1, 99, 10, 104, 5]
    expect(arr.index_of_max).to eq 3
  end
end


