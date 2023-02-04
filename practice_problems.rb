#1 — What will the following code output? Why?

class Student
  attr_reader :id
  attr_writer :id

  def initialize(name)
    @name = name
    @id
  end

  def update_id(value)
    self.id = value
  end
end

tom = Student.new("Tom")
p tom.update_id(45)

