class Parent

  private
  def name
    'Mommy'
  end

  public
  def change_name
    puts "#{name} & Daddy"
  end
end

class Child < Parent
  def get_parent_name
    # Implicit receiver
    puts name

    # Explicit receiver
    puts self.change_name rescue puts 'NoMethodError'

    # Explicit receiver
    puts Parent.new.name rescue puts 'NoMethodError'
  end
end

Child.new.get_parent_name
Parent.new.change_name
