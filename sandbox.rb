# Implement the given classes so that we get the expected results

class ClassLevel
  attr_accessor :level

  def initialize(level)
    @level = level
    @members = []
  end

  def <<(student)
    members.include?(student) ? "That student is already added" : members << student 
  end 

  def members 
    @members.each do |member|
      member 
    end 
  end 

  def valedictorian
    current_highest = 0
    val = ''

    members.each do |student|
      if student.gpa > current_highest 
        val = student
        current_highest = student.gpa 
      else 
        next 
      end 
    end 

    "#{val.name} is the valedictorian with a gpa of #{val.gpa}" 
  end 



end

class Student
  include Comparable 

  attr_accessor :name, :gpa
  
  def initialize(name, id, gpa)
    @name = name
    @id = id
    @gpa = gpa
  end

  def to_s
    "--------------
    Name: #{name}
    Id: #{id} 
    GPA: #{gpa}
    --------------"
  end 

  def ==(other)
    id == other.id 
  end 

  def <=>(other)
    gpa <=> other.gpa
  end 


  protected
  
  def id 
    last_3 = @id.split.last(3)
    "XXX-XX-#{last_3}"
  end 
end

juniors = ClassLevel.new('Juniors')

anna_a = Student.new('Anna', '123-11-123', 3.85)
bob = Student.new('Bob', '555-44-555', 3.23)
chris = Student.new('Chris', '321-99-321', 2.98)
david = Student.new('David', '987-00-987', 3.12)
anna_b = Student.new('Anna', '543-33-543', 3.76)

juniors << anna_a
juniors << bob
juniors << chris
juniors << david
juniors << anna_b

p juniors << anna_a
  # => "That student is already added"

puts juniors.members
  # => ===========
  # => Name: Anna
  # => Id: XXX-XX-123
  # => GPA: 3.85
  # => ==========
  # => ...etc (for each student)

p anna_a == anna_b 
  # => false

p david > chris
  # => true

p juniors.valedictorian
  # => "Anna has the highest GPA of 3.85"