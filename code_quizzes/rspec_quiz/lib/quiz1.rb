def word_count(string)
    string.split.size
  end

def average_word_length(string)
  string == "" ? nil : string.gsub(' ', '').length / string.split.size.to_f
end

class String
  def palindrome?
    self == reverse
  end

  def strip_whitespace
    gsub(/[ ]/, '')
  end

  def titlecase
    split.map(&:capitalize).join(' ')
  end

  def delete_last(number)
    number.times {chop!}
    self
  end

  def date_convertible?
  end
end

def vowels(str)
  #str.split.inject([]){|result, word| word.scan(/[aeiou]/) == [] ? result : result << word}
  str.split.select{|word| word.match(/[aeiou]/)}
end

def start_with_c?(str)
  str.split.all? do |word|
    word[0] == 'c'
  end
end
