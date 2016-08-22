# design is refactoring - przykłady i notatki do poszczególnych artykułów

# default method definition

#Decorators, presenters = alias: formatters, service_objects, (pattern) ex. ruby decorations pattern


# bank

#uzytkownik ma konto, wybiera kase, wplaca itp.

p 2.4.truncate.is_a?(Integer)

p 'sadsko'.truncate




class Person
  def name
    'Atomek'
  end

  def age
    99
  end
end

class Assignement
  def_delegator :name, :age, :person # lub @person bez dodatkowej metody person

  def initialize
    @person = Person.new
  end

  def display
    "Task assigned to: #{name} age: #{age}"
  end

  def person
    @person
  end
end

p Assignement.new.display

