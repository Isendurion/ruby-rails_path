class Student

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student)
    grade > student.grade
  end

  protected

  def grade
    @grade
  end
end

mary = Student.new('Mary', 4)
martha = Student.new('Martha', 2)
#puts mary.grade
puts "Nice! :)" if mary.better_grade_than?(martha)