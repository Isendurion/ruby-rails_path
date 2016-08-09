require 'Date'

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

  # def date_convertible?
  #   ( self[0..3].to_i.between?(1, 9999) ) && ( self[4..5].to_i.between?(1, 12) ) && ( self[6..7].to_i.between?(1, 31) )
  # end

  def date_convertible?
    !!(Date.parse(self) rescue false)
  end

  def parse_params
    if self.include?'?'
      params = self.split('?').last
      Hash[params.split('&').map{|p| p.split('=')}]
    else nil
    end
  end

  def acronym?(word)
    gsub(/\s*(\S)\S*/, '\1') == word #gets first letter from every word in a string
  end

  def alliteration?
    gsub(/\s*(\S)\S*/, '\1').split('').uniq.length == 1
  end

  def numeric?
    to_f == 0.0 ? !(to_f) : !!(to_f)
    # !!(Float(self) rescue false)
  end

  def insert_multiple(values)
    self.each_char.with_index.inject('') do |memo, (c,i)|
      memo + values.fetch(i,'') + c
    end
  end
end

class Float
  def to_money
    # if self.to_s[-1] == '0'
    #   "$#{self.round(2)}0"
    #   else "$#{self.round(2)}"
    # end

    "$#{sprintf("%#.2f", self)}"
  end
end

class Integer
  def concat(some_int)
    "#{self}#{some_int}".to_i
  end
end

def word_count(string)
    string.split.size
  end

def average_word_length(string)
  string == "" ? nil : string.gsub(' ', '').length / string.split.size.to_f
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
