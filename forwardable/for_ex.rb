require 'forwardable'

class Person
  def name
    'Atomek'
  end

  def age
    99
  end
end

class Assignement
  extend Forwardable

  def_delegators  :person, :name, :age

  def initialize
    @person = Person.new
  end

  def display_it
    "Task assigned to: #{name} age: #{age}"
  end

  def person
    @person
  end

  def title
    "assignement title"
  end
end

p Assignement.new.display_it

class Book
  def language
    "English"
  end

  def year
    "1926"
  end

  def author
    "Ernest Hemingway"
  end

  def title
    "The Sun Also Rises"
  end
end

class Product
  extend Forwardable

  def_delegators :@book, :language, :year, :author, :info
  def_delegator :@book, :title, :info
  def_delegator :@assignement, :title

  def initialize
    @book = Book.new
    @assignement = Assignement.new
  end
end

p Product.new.info
p Product.new.title
