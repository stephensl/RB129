# problems from https://medium.com/@marwan.zaarab/rb129-interview-assessment-prep-e2f120330240


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





#16 — Update the Human class to have lines 11 and 14 return the desired output.

# class Human 
#   attr_reader :name

#   def initialize(name="Dylan")
#     @name = name
#   end
# end

# puts Human.new("Jo").hair_color("blonde")  
# # Should output "Hi, my name is Jo and I have blonde hair."

# puts Human.hair_color("")              
# # Should "Hi, my name is Dylan and I have blonde hair."



# class Human 
#   attr_reader :name, :hair_color

#   def initialize(name="Dylan")
#     @name = name
#   end

#   def hair_color(color)
#     "Hi my name is #{name} and I have #{color} hair."
#   end 

#   def self.hair_color(color)
#     color = color.empty? ? 'blonde' : color 
#     "Hi, my name is #{self.new.name} and I have #{color} hair."
#   end 
# end

# puts Human.new("Jo").hair_color("blonde")  
# # Should output "Hi, my name is Jo and I have blonde hair."

# puts Human.hair_color("")              
# Should "Hi, my name is Dylan and I have blonde hair."

# This works, but it is weird practice. 




# Here's how I would implement the class: 

# class Human 
#   attr_reader :name, :hair_color 

#   @@generic_name = "Dylan"

#   def initialize(name = 'Dylan')
#     @name = name 
#   end 

#   def hair_color=(color)
#     @hair_color = color 
#   end 

#   def to_s
#     if hair_color 
#       "Hi, my name is #{name} and I have #{hair_color} hair."
#     else 
#       "Hi, my name is #{name}."
#     end 
#   end 

#   def self.hair_color(color)
#     @@hair_color = color.empty? ? 'blonde' : color 
#     "Hi, my name is #{@@generic_name} and I have #{@@hair_color} hair."
#   end 
# end 

# jo = Human.new('Jo')
# jo.hair_color = 'blonde'
# puts jo      # => Hi, my name is Jo and I have blonde hair.

# puts Human.hair_color('') # => Hi, my name is Dylan and I have blonde hair.

# Either way, strange problem and I would not write code like this.




#17 — What does each self refer to in the code snippet below?

# class MeMyselfAndI
#   self     # => class 

#   def self.me # => class definition
#     self      # => class
#   end

#   def myself
#     self      # => calling object
#   end
# end

# i = MeMyselfAndI.new

# self used inside a class but outside of an instance method references the class itself, whereas self used within an instance method references the calling object. self is also used to define class methods. self is utilized in order to be explicit about what is being referenced in the program and changes depending on the context. 



#18— What are some of the characteristics of instance variables?

# - Instance variables are one way that we tie data to objects, and keep track of an object's state. Each individual instance has its own set of instance variables unique to the object. 

# - Instance variables have a default value of nil until initialized. 

# - Instance variables can be accessed within instance methods without being passed in or initialized within the method. 

# - Instance variables are encapsulated within the object and are not accessible outside of the class. In order to expose, set, or change the value assigned to an instance variable, an interface must be provided. 



# Problems from SPOT wiki ... not best practice to write code this way, but more for thinking exercises. 



# Add 1 line of code for the person class
# and 1 line of code in the initalize method. 
# Other than that don't change Person.


# class Person
#   def initialize(name, job)
#       @name = name
#   end 
# end

# roger = Person.new("Roger", "Carpenter")
# puts roger

# Output:
# "My name is Roger and I am a Carpenter"




# At this point, we are instantiating a new Person object, and passing in two arguments. Within the initialize method, we are only initializing a single instance variable @name, and the second argument is not used. 

# This code would need to be updated to: 

# class Person 
#   attr_reader :to_s 

#   def initialize(name, job)
#     @name = name 
#     @to_s = "My name is #{name} and I am a #{job}."
#   end 
# end 

# roger = Person.new("Roger", "Carpenter")
# puts roger # => "My name is Roger and I am a Carpenter"





# give class Barbarian the functionality of the Monster instance attack method:
  # If you used class inheritance, now try doing it without class inheritance directly.
  # If you used modules, now try not using modules
  # If you used duck typing, now don't use duck typing 

# class inheritance 
  
# class Monster
#   def attack
#     "attacks!"
#   end
# end
  
# class Barbarian < Monster
# end


# # module (interface inheritance)

# module Attackable 
#   def attack 
#     "attacks"
#   end 
# end 

# class Barbarian
#   include Attackable 
# end 

# class Monster 
#   include Attackable 
# end 


# # Duck typing 

# class Barbarian 
#   def attack 
#     "#{self.class} attacks!"
#   end 
# end 

# class Monster 
#   def attack 
#     "I'm attacking because I'm a #{self.class}"
#   end 
# end 

# conan = Barbarian.new 
# nessie = Monster.new 

# [conan, nessie].each { |obj| puts obj.attack }

# => Barbarian attacks!
# => I'm attacking because I'm a Monster




# Without adding any methods below, implement a solution;

# class ClassA 
#   attr_reader :field1, :field2
  
#   def initialize(num)
#     @field1 = "xyz"
#     @field2 = num
#   end
# end

# class ClassB 
#   attr_reader :field1

#   def initialize
#     @field1 = "abc"
#   end
# end


# obj1 = ClassA.new(50)
# obj2 = ClassA.new(25)
# obj3 = ClassB.new


# p obj1 > obj2
# p obj2 > obj3

# # ANSWER

# p obj1.field2 > obj2.field2    # true
# p obj2.field1 > obj3.field1    # true







# Update the class to receive the proper output.

# class BenjaminButton 
  
#   def initialize
#   end
  
#   def get_older
#   end
  
#   def look_younger
#   end
  
#   def die
#   end
# end

# benjamin = BenjaminButton.new
# p benjamin.actual_age # => 0
# p benjamin.appearance_age # => 100

# benjamin.actual_age = 1
# p benjamin.actual_age

# benjamin.get_older
# p benjamin.actual_age # => 2
# p benjamin.appearance_age # => 99

# benjamin.die
# p benjamin.actual_age # => 100
# p benjamin.appearance_age # => 0



# class BenjaminButton 
#   attr_accessor :actual_age, :appearance_age

#   def initialize
#     @actual_age = 0 
#     @appearance_age = 100 
#   end 

#   def get_older 
#     self.actual_age += 1 
#     self.appearance_age -= 1
#   end 

#   def die 
#     self.actual_age = 100
#     self.appearance_age = 0 
#   end 
# end 


# benjamin = BenjaminButton.new
# p benjamin.actual_age # => 0
# p benjamin.appearance_age # => 100

# benjamin.actual_age = 1
# p benjamin.actual_age # => 1

# benjamin.get_older
# p benjamin.actual_age # => 2
# p benjamin.appearance_age # => 99

# benjamin.die
# p benjamin.actual_age # => 100
# p benjamin.appearance_age # => 0







# Add only one line where directed.

# class Wizard
#   attr_reader :name, :hitpoints
  
#   def initialize(name, hitpoints)
#     @name = name
#     @hitpoints = hitpoints
#   end  
  
#   def fireball
#     "casts Fireball for 500 damage!"
#   end
# end

# class Summoner < Wizard
#   attr_reader :souls
  
#   def initialize(name, hitpoints)
#     super(name, hitpoints)          # line added, originally omitted 
#     @souls = []
#   end
  
#   def soul_steal(character)
#     @souls << character
#   end
# end

# gandolf = Summoner.new("Gandolf", 100)
# p gandolf.name # => "Gandolf"

# valdimar = Wizard.new("Valdimar", 200)
# p valdimar.fireball #=> "casts fireball for 500 damage!"

# p gandolf.hitpoints #=> 100

# p gandolf.soul_steal(valdimar) #=> [#<Wizard:0x000055d782470810 @name="Valdimar", @hitpoints=200>]

# p gandolf.souls[0].fireball #=> "casts fireball for 500 damage!"

# This problem demonstrates the use of super to call methods from earlier in the method lookup path. In this case, we are accessing behavior from the Wizard#initialize method by using the super keyword and passing in the relevant arguments to super within the Summoner#initialize method. 





# module Flightable
#   def fly
#     "I am #{name}, I am a #{self.class.to_s.downcase}, and I can fly"
#   end
# end

# class Superhero
#   include Flightable 

#   attr_accessor :ability
#   attr_reader :name
  
#   def initialize(name)
#     @name = name
#   end

#   def announce_ability
#     puts "I fight crime with my #{ability} ability!"
#   end

#   def self.fight_crime
#     puts "I am #{self}!"
#     announce_ability
#   end

#   def self.announce_ability
#     puts "I fight crime with my #{self::ABILITY} ability!"
#   end 
# end

# class LSMan < Superhero
#   ABILITY = 'coding skills'
# end

# class Ability
#   attr_reader :description

#   def initialize(description)
#     @description = description
#   end
# end

# superman = Superhero.new('Superman')

# p superman.fly # => I am Superman, I am a superhero, and I can fly!

# coding = Ability.new("coding skills")

# LSMan.fight_crime 
# # => I am LSMan!
# # => I fight crime with my coding skills ability!








####


# More practice 


# An animal shelter receives pets and facilitates adoptions of pets. Create an application that tracks data relative to the operation of the shelter.


# Spike practicing with multi line strings and %{} syntax versus " ". 

# class Shelter 
#   attr_reader :name, :current_residents
  
#   def initialize(name)
#     @name = name 
#     @current_residents = []
#   end

#   def check_in(pet)
#     @current_residents << pet
#   end 

#   def check_out(pet)
#     @current_residents.delete(pet)
#   end 

#   def print_current_residents
#     puts %{Current Residents at #{name}:}
#     puts %{-----------------------------}
#     current_residents.each do |resident|
#       puts resident
#     end 
#   end 
  
# end


# class Owner 
#   attr_reader :name, :pets
  
#   def initialize(name)
#     @name = name 
#     @pets = []
#   end 

#   def adopt(pet)
#     @pets << pet 
#   end 

#   def print_pets
#     puts "**#{name}'s Pets **"
#     puts "-------------------"
#     puts pets 
#   end 

# end 

# class Pet
#   attr_reader :name, :species
#   def initialize(name, species)
#     @name = name 
#     @species = species
#   end 

#   def to_s 
#     %[* A #{species} named #{name}]
#   end 
# end 


# good_hands = Shelter.new("Good Hands")

# louie = Pet.new("Louie", "Dog" )

# phil = Owner.new("Phil")

# good_hands.check_in(louie)

# good_hands.print_current_residents

# phil.adopt(louie)

# good_hands.check_out(louie)

# zuzu = Pet.new("Zuzu", "Dog")

# phil.adopt(zuzu)

# good_hands.check_out(zuzu)

# phil.print_pets

# => 

  # Current Residents at Good Hands:
  # -----------------------------
  # * A Dog named Louie


  # **Phil's Pets **
  # -------------------
  # * A Dog named Louie
  # * A Dog named Zuzu






# Medium Exercises 

# Modify this class so both flip_switch and the setter method switch= are private methods.

# class Machine
#   attr_writer :switch

#   def start
#     self.flip_switch(:on)
#   end

#   def stop
#     self.flip_switch(:off)
#   end

#   def flip_switch(desired_state)
#     self.switch = desired_state
#   end
# end


# Answer: 

# class Machine
#   def start
#     flip_switch(:on)
#   end

#   def stop
#     flip_switch(:off)
#   end

#   def switch_status
#     switch 
#   end 

#   private 

#   attr_accessor :switch

#   def flip_switch(desired_state)
#     self.switch = desired_state
#   end
# end

# mine = Machine.new 
# mine.start 
# mine.stop 

# p mine.switch_status




# Write a class that implements a fixed-length array, and provides the necessary methods to support the following code:

# fixed_array = FixedArray.new(5)
# puts fixed_array[3] == nil
# puts fixed_array.to_a == [nil] * 5

# fixed_array[3] = 'a'
# puts fixed_array[3] == 'a'
# puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

# fixed_array[1] = 'b'
# puts fixed_array[1] == 'b'
# puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

# fixed_array[1] = 'c'
# puts fixed_array[1] == 'c'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

# fixed_array[4] = 'd'
# puts fixed_array[4] == 'd'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
# puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

# puts fixed_array[-1] == 'd'
# puts fixed_array[-4] == 'c'

# begin
#   fixed_array[6]
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[-7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

#The above code should output true 16 times.


# class FixedArray 
#   attr_reader :array 

#   def initialize(size)
#     @size = size 
#     @array = Array.new(size)
#   end 

#   def [](index)
#     array.fetch(index)
#   end 

#   def []=(index, value)
#     self[index]           # raises error if index invalid 
#     array[index] = value 
#   end 

#   def to_a 
#     array.clone
#   end 

#   def to_s 
#     to_a.to_s 
#   end 
# end




# Below we have 3 classes: Student, Graduate, and Undergraduate. The implementation details for the #initialize methods in Graduate and Undergraduate are missing. Fill in those missing details so that the following requirements are fulfilled:

#     Graduate students have the option to use on-campus parking, while Undergraduate students do not.

#     Graduate and Undergraduate students both have a name and year associated with them.

# Note, you can do this by adding or altering no more than 5 lines of code.

# class Student
#   def initialize(name, year)
#     @name = name
#     @year = year
#   end
# end

# class Graduate
#   def initialize(name, year, parking)
#   end
# end

# class Undergraduate
#   def initialize(name, year)
#   end
# end



# ANSWER 

# class Student
#   def initialize(name, year)
#     @name = name
#     @year = year
#   end
# end

# class Graduate < Student
#   def initialize(name, year, parking)
#     super(name, year)
#     @parking = parking 
#   end
# end

# class Undergraduate < Student ; end

# Can you think of a way to use super() in another Student related class?

# class Student
#   def initialize(name, year)
#     @name = name
#     @year = year
#   end

#   def take_class 
#     "I am a(n) #{self.class} taking a class"
#   end 
# end

# class Graduate < Student
#   def initialize(name, year, parking)
#     super(name, year)
#     @parking = parking 
#   end
# end

# class Undergraduate < Student ; end

# class Auditor < Student 
#   def take_class(subject)
#     super() + " in #{subject}"
#   end 
# end 

# tom = Auditor.new('Tom', 2023)
# puts tom.take_class('History')   
  # => I am a(n) Auditor taking a class in History




#   Your task is to write a CircularQueue class that implements a circular queue for arbitrary objects. The class should obtain the buffer size with an argument provided to CircularQueue::new, and should provide the following methods:

#   enqueue to add an object to the queue
#   dequeue to remove (and return) the oldest object in the queue. It should return nil if the queue is empty.

# You may assume that none of the values stored in the queue are nil (however, nil may be used to designate empty spots in the buffer).


# class CircularQueue
#   attr_reader :size, :buffer

#   def initialize(size)
#     @size = size 
#     @buffer = []
#   end 

#   def enqueue(num)
#     dequeue if buffer.size == size 
#     buffer << num 
#   end 

#   def dequeue
#     return nil if buffer.empty?
#     buffer.shift 
#   end 
# end 




# queue = CircularQueue.new(3)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1


# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2


# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

# queue = CircularQueue.new(4)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

# The above code should display true 15 times.