class Array
  def has_string?
    self.any?{|item| item.class == String}
  end

  def sort_by_length
    self.sort{|first, second| first.length <=> second.length}
  end

  def mean
    result = self.inject {|sum, el| sum + el}
    result / self.length.to_f
  end

  def unzip
    numbers = []
    letters = []
    self.map do |num, letter|
      numbers << num
      letters << letter
    end
    result = []
    result << letters << numbers
  end

  def hashify
    self.each_slice(2).to_a.to_h
  end

  def super_compact
    self.delete_if{|o| o.nil? || o.empty?}
  end

  def tight_zip(ary)
    self.zip(ary).flatten.compact
  end

  def mode
    result = self.each_with_object(Hash.new(0)) do |element, hash|
      hash[element] += 1
    end
    result.sort_by(&:last).last.first
  end

  def first_duplicate
    self.find{|item| count(item) > 1}
  end

  def symbolize
    map(&:to_sym)
  end

  def index_of_max
    index max
  end

  def merge
    result = first.merge(last){|_, ov, nv| [ov, nv]}
    result.each{|k, v| result[k] = [v] unless result[k].is_a? Array}
  end

  def merge_overlapping_ranges
    result = []
    mem = []
    self.each_with_index do |range, index|
      if range.is_overlapping?(self[index+1])
        range.each{|item| mem << item}
        self[index+1].each{|item| mem << item}
        result << Range.new(mem.uniq.first, mem.uniq.last)
      elsif index != self.length-1
        result << range
      end
    end
    result
  end
end

class Range
  def is_overlapping?(r)
    r.first <= self.last unless r.nil?
  end
end
