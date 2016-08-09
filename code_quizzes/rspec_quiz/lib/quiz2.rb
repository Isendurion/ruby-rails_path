class Array
  def has_string?
    self.any?{|item| item.class == String}
  end

  def sort_by_length
    self.sort{|first, second| first.length <=> second.length}
  end

  def mean
    self.inject do |sum, el|
      sum += el
      sum/self.length
    end
  end
end
