#1 — What will the following code output? Why?

# class Student
#   attr_reader :id

#   def initialize(name)
#     @name = name
#     @id
#   end

#   def id=(value)
#     self.id = value
#   end
# end

# tom = Student.new("Tom")
# tom.id = 45     # Error- recursive loop 

# This code did not produce the intended output as on line 11 we are defining the setter method id=, and invoking it via self.id = value in the body of the method. This will create a recursive loop and a "stack level too deep" error. 

# In order to fix the code, we can either define a setter method utilizing the shorthand attr_writer :id or in this case, attr_accessor :id to create a setter method and call it from within an instance method.

#   def update_id(value)
#     self.id = value
#   end

# Or, we could define the setter method as follows: 

#   def id=(value)
#     @id = value 
#   end 

# This would change the value assigned to instance variable @id directly. 




#2 — Define a class of your choice with the following:

# Constructor method that initializes 2 instance variables.

# Instance method that outputs an interpolated string of those variables.

# Getter methods for both (you can use the shorthand notation if you want).

# Prevent instances from accessing these methods outside of the class.

# Finally, explain what concept(s) you’ve just demonstrated with your code.


# class Athlete
#   def initialize(name, age)
#     @name = name 
#     @age = age 
#   end 

#   def to_s 
#     "My name is #{name} and I am #{age} years old"
#   end 

#   private 

#   attr_reader :name, :age 
# end 

# mj = Athlete.new("Michael", 23)
# puts mj # => My name is Michael and I am 23 years old

# Demonstrates: 

#   - overriding the Object#to_s method and creating a custom Athlete#to_s method to output a string representation of the object. 

#   - Encapsulation by hiding functionality and implementation details from other parts of the program, and providing an interface in order to interact with the object. 

#   - Method access control by utilizing the access modifier private to ensure that methods defined below the private access modifier are not available outside of the class definition or by any instance of Athlete other than the current object. This provides data protection and prevents unintentional exposure or manipulation. 





#3 — What concept does the following code aim to demonstrate?

# module Greet
#   def greet(message)
#     puts message
#   end
# end

# class Teacher
#   include Greet
# end

# class Student
#   include Greet
# end

# tom = Teacher.new
# rob = Student.new

# tom.greet "Bonjour!"  # => Bonjour
# rob.greet "Hello!"    # => Hello!

# This code demonstrates one use case for modules as we mix in the Greet module via the include method in both the Teacher and Student classes. As a result, the functionality of each class is extended to allow for instances of the class to access instance methods defined in the Greet module. This demonstrates interface inheritance, as the Teacher class and the Student class are able to manifest behaviors defined in the mixed in module, rather than defining the shared behavior explicitly within each class, or utilizing class inheritance to access to shared behavior. This code also demonstrates polymorphism via interface inheritance as objects of different types (in this case Teacher and Student objects) are able to respond to the same method call. 




#4 — What will the last line of code return?

# class Student
#   def initialize(id, name)
#     @id = id
#     @name = name
#   end
  
#   def ==(other)
#     self.id == other.id
#   end

#   private
  
#   attr_reader :id, :name
# end

# rob = Student.new(123, "Rob")
# tom = Student.new(456, "Tom")

# rob == tom


# This code will raise an error for a private method id. Private methods are only accessible within the class definition to the current object, and not other instances of the class. When we attempt to invoke the getter method id on the argument passed in to the == method, we get an error. 


# class Student
#   def initialize(id, name)
#     @id = id
#     @name = name
#   end
  
#   def ==(other)
#     self.id == other.id
#   end

#   protected  # changed from private to protected 
  
#   attr_reader :id, :name
# end

# rob = Student.new(123, "Rob")
# tom = Student.new(456, "Tom")

# p rob == tom  # => false

# Demonstrates: 

# - Method access control, private methods can only be invoked by the current object, while protected methods can be invoked by all instances of the class. 
# - We are overriding the inherited BasicObject#== method, which evaluates whether or not the two objects being compared are the same object, by defining class specific behavior relevant to the desired functionality of the method. 




#6 — Will the following code execute? What will be the output?

# class Person
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def greet
#      "Hello! they call me #{name}"
#   end
# end

# class Puppet < Person
#   def initialize(name)
#     super
#   end

#   def greet(message)
#     puts super + message
#   end
# end

# puppet = Puppet.new("Cookie Monster")
# puppet.greet(" and I love cookies!")

# this will raise an error for incorrect number of arguments 1 when 0 expected. super automatically forwards all arguments passed in to the method within which super is called to the superclass method of the same name. In this case the superclass instance method Person#greet takes no arguments, thus giving us the error. In order to remedy this, we must explicitly send 0 arguments to the Person#greet method in order to achieve the expected behavior. 

# class Person
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def greet
#      "Hello! they call me #{name}"
#   end
# end

# class Puppet < Person
#   def initialize(name)
#     super
#   end

#   def greet(message)
#     puts super() + message    # super changed to super()
#   end
# end

# puppet = Puppet.new("Cookie Monster")
# puppet.greet(" and I love cookies!") 

# => Hello! they call me Cookie Monster and I love cookies!





#7 — What concept does this code demonstrate? What will be the output?

# class Bird
#   def fly
#     p "#{self.class} is flying!"
#   end
# end

# class Pigeon < Bird; end
# class Duck < Bird; end

# birds = [Bird.new, Pigeon.new, Duck.new].each(&:fly)

# This demonstrates polymorphism through inheritance as subclasses of Bird are able to access shared behavior defined in the superclass. Also, polymorphism allows for objects of different types, in this case Bird, Pigeon, and Duck types, to respond to the same interface (instance method #fly). 

# This will output: 

# Bird is flying!
# Pigeon is flying!
# Duck is flying!

# Polymorphism allows for different data types to respond to a common method invocation, usually, though not always in different ways. 




#8 — What does the self keyword refer to in the good method?

# class Dog
#   attr_accessor :name

#   def good
#     self.name + " is a good dog"
#   end
# end

# bandit = Dog.new
# bandit.name = "Bandit"
# p bandit.good

# The self keyword in the Dog#good instance method refers to the calling object, as self used within an instance method refers to the object that invokes the method. In this case, on line 260 we invoke the instance method #good on our Dog object assigned to local variable bandit- when the code on line 254 is executed, self.name is functionally the same as calling bandit.name, as it refers to the calling object. 

# This code will output "Bandit is a good dog" and return nil. 





#9 — What will the last three lines of code print to the console? 

# After song.artist is called, what would be returned if we inspect the song object?

# class Song
#   attr_reader :title, :artist

#   def initialize(title)
#     @title = title
#     @artist
#   end

#   def artist=(name)
#     @artist = name.upcase
#   end
# end

# p song = Song.new("Superstition")  
  # => <Song: encoded object_id, @title = "Superstition">

# p song.artist = "Stevie Wonder"
  # => "Stevie Wonder"

# p song.artist
  # => "STEVIE WONDER"

# p song 
# => <Song: encoded object id @title = "Superstition" @artist = "STEVIE WONDER">





#10 — What will the last 2 lines output in this case?

# class Song
#   attr_reader :title, :artist

#   def initialize(title)
#     @title = title
#   end

#   def artist=(name)
#     @artist = name
#     name.upcase!
#   end
# end

# song = Song.new("Superstition")
# p song.artist = "Stevie Wonder"   # => STEVIE WONDER
# p song.artist                     # => STEVIE WONDER

# While setter methods always return the value that is passed in as an argument, if the argument is mutated, this will be reflected in the value assigned to the instance variable being set because we are mutating the string object in place. 




#11 — What would cat.name return after the last line of code is executed?

# class Cat
#   attr_accessor :name

#   def set_name
#     name = "Cheetos"
#   end
# end

# cat = Cat.new
# cat.set_name

# cat.name # => nil 

# This will output nil due to the instance variable @name never being initialized. On line 333, Ruby interprets this as initializing a new local variable, rather than calling a setter method. In order to remedy this, we need to either reference the instance variable @name directly, or use self.name = "Cheetos" in order to disambiguate between creating a new local variable and calling a setter method. 



#12 — What will the last two lines of code output?

# module Walk
#   STR = "Walking"
# end

# module Run
#   STR = "Running"
# end

# module Jump
#   STR = "Jumping"
# end

# class Bunny
#   include Jump
#   include Walk
#   include Run
# end

# class Bugs < Bunny; end

# p Bugs.ancestors
# # => [Bugs, Bunny, Run, Walk, Jump, Object, Kernel, BasicObject]

# p Bugs::STR
# # => "Running"



#14 — Write 3 methods inside the Person class that would return the outputs shown on the last two lines.

# class Person
#   attr_reader :friends

#   def initialize
#     @friends = []
#   end
# end

# class Friend
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end
# end

# tom = Person.new
# john = Friend.new('John')
# amber = Friend.new('Amber')

# tom << amber
# tom[1] = john
# p tom[0]      # => Amber
# p tom.friends # => ["Amber", "John"]


# In order to achieve the desired return values from the last two lines, we need to define the <<, [], and []= methods for the Person class. These methods allow for syntactical sugar to be utilized in order for more intuitive use outside of the class. 

# class Person
#   attr_reader :friends

#   def initialize
#     @friends = []
#   end

#   def <<(other)
#     friends << other.name 
#   end 

#   def []=(index, other)
#     friends[index] = other.name 
#   end 

#   def [](index)
#     friends[index]
#   end 
# end

# class Friend
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end
# end

# tom = Person.new
# john = Friend.new('John')
# amber = Friend.new('Amber')

# tom << amber
# tom[1] = john   # same as:  tom.[]=(1, john)

# p tom[0] # same as tom.[](0)      # => Amber
# p tom.friends # => ["Amber", "John"]



