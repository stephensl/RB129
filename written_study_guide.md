# OOP Benefits
  - Manage complexity of large programs
  - Reduce dependencies by creating containers for code that can be manipulated without causing ripple effects throughout the program. 
  - Higher level of abstraction. Use real world nouns and verbs to model relationships and behavior in the program. 
  - Better organization through modularity aids in maintaining code.
  - Code reusability, helps create DRY code
  - Inheritance and polymorphism: being able to share behaviors among objects

# Classes
Classes act as blueprints for objects by determining what an object of the class should be made of (attributes), and what it is capable of doing (behaviors). Objects are instantiated from a class which provides a formal way of grouping objects based on shared characteristics. 

# Objects 
Objects are instances of a class and contain state and behavior. Each individual object encapsulates its own unique state which is tracked through an object's instance variables. Objects contain shared behavior that may be defined or inherited by the class from which it is instantiated. Nearly everything in Ruby is an object, specifically, anything that has a value is an object (exceptions include methods, blocks, variables). Objects are instantiated by calling the `Class#new` method and the return value is an object of the calling class. 

# Getter Method
A getter method is an instance method that exposes the value of an instance variable. Getter methods may be invoked outside of the class definition (assuming the method is not `private` or `protected`) or within instance methods. 

Utilizing a getter method to reference a value assigned to an instance variable is preferred to referencing instance variables directly in the class definition, and is the only way to access instance variable values outside of the class definition (data is private by default).

Benefits of utilizing getter methods instead of referencing instance variables directly within the class is that getter methods allow for flexibility in exposing information about an object's state. Getter methods allow us to apply formatting and set intentional parameters around how information about the state of an object is exposed. They also allow for greater code maintainability for future changes as they can happen in one place rather than everywhere the instance variable is directly referenced. 


Utilizing getter methods also provides a level of protection against introducing bugs through a mistyped instance variable name, as a mistyped instance method name would issue an exception.

```ruby 
class Athlete 
  attr_reader :name

  def initialize(name)
    @name = name 
  end 

  def introduce_with_ivar
    "My name is #{@namee}" # mistyped 
  end 

  def introduce_with_getter
    "My name is #{namee}" # mistyped
  end 
end 

serena = Athlete.new('Serena')
puts serena.introduce_with_ivar # =>  My name is (does NOT throw error)

puts serena.introduce_with_getter
# => Error for undefined local variable or method `namee`.
```

Getter methods can be defined explicitly within the class: 

```ruby 
class Athlete
  def initialize(name, sport)
    @name = name    
    @sport = sport 
  end 

  def name  # getter method
    @name 
  end 

  def sport # getter method
    @sport 
  end 

  def to_s # getter methods interpolated
    "My name is #{name} and I play #{sport}."
  end 
end 

serena = Athlete.new('Serena', 'tennis')

# Utilizing getter method outside of class definition. 
puts serena.name  # => 'Serena' 
puts serena.sport # => 'tennis'

# Calling instance method to_s implicitly, which utilizes getter methods in implementation.
puts serena      
# => My name is Serena and I play tennis.
```

Getter methods can also be created using an accessor method. 

```ruby 
class Athlete
  # creates getter method
  attr_reader :name 
  
  def initialize(name)
    @name = name 
  end 

  def introduce 
    "My name is #{name}" # getter method
  end 
end 
 
serena = Athlete.new('Serena')

puts serena.name   # => 'Serena'
serena.introduce   # => My name is Serena 
```

# Setter Method
Setter methods are instance methods that allow for changes to be made to an object's state. An object's state may be altered through utilizing setter methods to set or change values referenced by the object's instance variables. 

Setter methods may be defined in a class explicitly: 
```ruby 
class Fruit 
  attr_reader :color 
  
  def initialize(type, color)
    @type = type
    @color = color 
  end 

  def color=(new_color)  # setter method
    @color = new_color 
  end 
end 

apple = Fruit.new('apple', 'red')
puts apple.color # => red

apple.color = 'green' # call setter method

# same as apple.color=('green'). Ruby provides more natural syntax. 

puts apple.color # => 'green'
```

Setter methods may also be defined using an accessor method.

```ruby 
class Fruit 
  attr_accessor :color 

  def initialize(type, color)
    @type = type
    @color = color 
  end 
end 

apple = Fruit.new('apple', 'red')
puts apple.color # => 'red'
apple.color = 'green'  # setter method call
puts apple.color # => 'green'
```

Setter methods always return the value that was passed in as an argument, regardless of what else occurs within the method. 

```ruby 
class Fruit 
  def color=(new_color)
    @color = new_color 
    "i will not be returned" 
  end 
end 

apple = Fruit.new
puts (apple.color = 'green') # => green

# *if argument is mutated within the setter method, the mutated argument will be returned*

class Fruit
  attr_reader :color 

  def color=(new_color)
    @color = new_color.upcase!
  end 
end

apple = Fruit.new
puts (apple.color = 'green') # => GREEN
puts apple.color # => GREEN
```

# Instance Variables
Instance variables are one way that we tie data to objects. Instance variables keep track of information about an object's state. Instance variables are scoped at the object level, meaning they are accessible within instance methods without being passed in or initialized within the instance method. Instance variables are private by default and can only be exposed or changed outside of the class definition through public getter and setter methods. 

```ruby 
class Shoe
  def initialize(size, color)
    @size = size # instance variable @size
    @color = color # instance variable @color
  end 

  def info
    "#{@color} shoes, size: #{@size}"
    # instance variables accessible here
  end 
end 

nike = Shoe.new(11, 'black')
puts "I wear size #{@size} shoes" # NOT accessible here.
```

### How inheritance affects instance variable scope: 

Instance variables and their values are not inherited. They must be initialized by calling the instance method within which the instance variable is initialized. 
```ruby 
class Food 
  def make_healthy
    @healthy = true
  end 
end 

class Fruit < Food 
  attr_reader :type

  def initialize(type)
    @type = type 
  end 

  def is_healthy? 
    return true if @healthy 
  end 
end 

apple = Fruit.new('apple')
p apple.is_healthy?   # => nil 

# The instance variable @healthy is never initialized because the Food#make_healthy method is never called. Instance variables are not inherited, and must be initialized by calling the appropriate instance method before they are initialized in the current object. 

apple = Fruit.new('apple')
p apple.is_healthy?   # => nil 
apple.make_healthy    # @healthy initialized!
p apple.is_healthy?   # => true
```

# Instance Methods 
Instance methods are available to all objects instantiated from the class and provide an interface to interact with objects. We can expose or change information about an object's state through its instance methods. All instances of a particular class share the same behaviors but have unique state. Instance variables can be accessed within instance methods without being passed in or initialized within the instance method. 

Example of instance methods:
```ruby 
class Chef 
  attr_reader :name, :restaurant

  def initialize(name)  # instance method 
    @name = name 
  end 

  def cook              # instance method 
    "I'm cooking!"
  end 

  def open_restaurant(restaurant)     # instance method
    @restaurant = restaurant 
  end 

tony = Chef.new('Tony')
puts tony.cook                       # instance method call   #=> I'm cooking!
tony.open_restaurant('The Grill')    # instance method (setter) #=> The Grill
tony.name                            # instance method call   #=> Tony
```

# Class Variables 
Class variables are used to store information relevant to the class rather than particular instances of the class. Class variables are prepended with `@@` and are scoped at the class level. Objects instantiated from the class each share one copy of class variables, and we are able to expose and change class variables from within instance methods. 

Example of class variable: 
```ruby 
class Musician
  @@total_musicians = 0       # class variable 

  def self.total_musicians 
    @@total_musicians         # accessible within class methods
  end 

  def initialize(name)
    @name = name 
    @@total_musicians += 1   # accessible within instance methods 
  end 

  def total_musicians        # instance method exposing value of class variable
    @@total_musicians 
  end 
end 
```
### Class variables and inheritance
It is best to avoid using inheritance when working with class variables as each object instantiated from the class in which the class variable is initialized, as well as subclasses, and instances of subclasses, share one copy of the class variable. Class variables may be accessed and reassigned from within instance methods, or class methods and any modifications will be reflected throughout the inheritance hierarchy. 

Example of danger of using class variable with inheritance:
```ruby 
class Athlete
  @@number_of_athletes = 0 

  def initialize(name)
    @name = name 
    @@number_of_athletes += 1
  end 

  def self.number_of_athletes
    @@number_of_athletes
  end 
end 

class Swimmer < Athlete
  @@number_of_athletes = 25 
end 

puts Athlete.number_of_athletes      # => 25 
```
This code demonstrates the danger of using class variables when working with inheritance as class variables may be modified by subclasses, as only one copy is shared between the class where it is initialized and all of its subclasses. Subclasses may override superclass class variables and the change will be reflected in the parent class and all subclasses.

# Class Methods
Class methods are methods that are defined within a class definition, and are invoked on the class itself without having to instantiate any objects. Class methods are utilized to manifest class-level behavior that does not deal with the state of individual objects. Class methods are defined by prepending `self` before the method name in the method definition. This `self` refers to the class itself, as the method is being defined on the class. 

Example of class method: 
```ruby 
class Fruit
  @@number_of_fruits = 0
  
  def initialize
    @@number_of_fruits += 1
  end 
  
  def self.number_of_fruits     # class method 
    @@number_of_fruits
  end 
end 

puts Fruit.number_of_fruits # => 0   # called directly on the class 
apple = Fruit.new 
puts Fruit.number_of_fruits # => 1
```
### Class method scope and inheritance
Class methods are scoped at the class level and can access class variables as long as the class variable has been initialized prior to the method call. 

Class methods are inherited by subclasses and may be invoked directly on the subclass. 

Example: 
```ruby 
class Animal 
  def self.what_am_i
    self 
  end 
end 

class Dog < Animal 
end 

puts Dog.what_am_i    #=> Dog
``` 
All objects instantiated from the class or subclasses share one copy of the class variable. Objects can access class variables within instance methods, but class methods cannot access instance variables or instance methods directly. Additionally, class methods cannot be called directly on an instance. 

# Constants 
Constants may be initialized globally, within class or module definitions, as well as within instance methods. Constants have a lexical scope, meaning that where a constant is available is dependent on the code construct and inheritance hierarchy surrounding the reference. 

In order to resolve constants, Ruby inspects the following lookup path: 
  - lexical scope 
  - inheritance hierarchy of structure that references constant 
  - top level scope

Example: 
```ruby 
module Wheelable
  WHEELS = 4
end 

class Bike
  include Wheelable 

  WHEELS = 2 

  def wheels
    WHEELS
  end 
end 

class Tricycle < Bike 
  WHEELS = 3
end 

my_trike = Tricycle.new 
puts my_trike.wheels     # => 2 
```
Ruby searches the lexical scope of the code construct surrounding the reference first. When we call `my_trike.wheels` the `wheels` method is invoked from the parent class `Bike#wheels` and that serves as the starting point for Ruby to search in order to resolve the constant. Ruby finds the constant `WHEELS` initialized in the `Bike` class and the value `2` is returned. Even though it was a `Tricycle` object that invokes the `wheels` method, lexical scoping rules dictate that constant resolution will begin within the lexical scope of the construct containing the reference, which in this case is the `Bike` class. 


This could be remedied by changing the body of the `wheels` method to: 

```ruby
...

def wheels
  self.class::WHEELS
end 

puts my_trike.wheels     # => 3 
...
```
If this were the case, when we call `wheels` method on our `Tricycle` object, the body of the `wheels` method would effectively be calling `Tricycle::WHEELS`, which would initiate the constant resolution path in the lexical scope of the `Tricycle Class`.

# Method Access Control 
Method access control allows programmer to enable or restrict access to behavior through the use or access modifiers: `public`, `protected`, and `private`. Method access control demonstrates the concept of encapsulation, as we set boundaries around access to behavior and hide implementation details from other areas of the program. This allows for the programmer to make explicit design decisions regarding the exposure or manipulation of data outside of the class, protecting data from unintentional alterations that may have consequences throughout the program. 

Methods defined in a class are public by default and comprise a class's public interface, which is how other classes and objects interact with the class and it's objects. Public methods can be accessed from anywhere within the program assuming we know the class name or object's name. The class should have as few public methods as possible. It lets us simplify using that class and protect data from undesired changes from the outer world.
```ruby 
class Athlete
  def play_sport        # public method
    "I'm playing my sport!"
  end 
end 

tom = Athlete.new
puts tom.play_sport      #=> I'm playing my sport!
```

`Private` methods cannot be accessed outside of the class definition, and are only available to be called on the current object. We define `private` methods by calling the `private` method in the class definition, and all methods defined below the `private` method will be `private`. 
```ruby 
class Athlete
  def initialize(name, sport)
    @name = name 
    @sport = sport 
  end 

  def play_sport 
    "#{name} is playing #{sport}"
  end 

  private 

  attr_reader :name, :sport  # two private getters
end 

tom = Athlete.new('Tom', 'Football')
puts tom.name   #=> Error private method 
puts tom.sport  #=> Error private method 
puts tom.play_sport #=> Tom is playing Football
```

`protected` methods are similar to `private` methods in that they do not allow access from outside of the class definition, but provide increased flexibility as they can be invoked from within the class definition on any instances of the class, not only the current object. 

```ruby 
class Athlete
  def initialize(name, number)
    @name = name 
    @jersey_number = number
  end

  def same_number_as(other)
    jersey_number == other.jersey_number
  end 

  protected 

  attr_reader :jersey_number
end 

tom = Athlete.new('Tom', 12)
mj = Athlete.new('Michael', 23)
p tom.same_number_as(mj) #=> false 
```
This code demonstrates the use of `protected` methods in achieving method access control. `protected` methods can be invoked on all instances of the class in which the method is defined, allowing us to call the protected getter method `jersey_number` on the current object `tom` as well as another instance of the `Athlete` class, `mj`, within the body of the `same_number_as` instance method. `same_number_as` utilizes `Integer#==` to compare the two integers returned by the `jersey_number` getter method call on `tom` and `mj` and returns `false`. 

# Referencing and Setting instance variables vs using getters and setters. 
Instance variables allow us to tie data to objects and keep track of an object's state. Instance variables are private by default and cannot be accessed directly outside of the class definition. In order to expose or manipulate information about an object's state, namely the values of its instance variables, we must provide an interface (instance methods) to do so.


### Referencing an instance variable inside the class definition. 

Instance variables can be referenced and reassigned directly within instance methods. 
```ruby 
class Fruit 
  def initialize(type)
    @type = type 
  end 

  def type   
    @type
  end 

  def type=(new_type)
    @type = new_type 
  end 

  def say_hello # referencing ivar directly
    "A friendly #{@type} saying hello"
  end 
end 
```
We can also reference and reassign instance variables using getter and setter methods within the class definition. 
```ruby 
class Fruit 
  #...omitted code same as above...#

  def say_hello # call to getter method
    "A friendly #{type} saying hello"
  end 

  def change_type(new_type)
    self.type = new_type  # call to setter
  end 
```
It is preferable to use getter and setter methods to reference and set instance variables rather than directly. Getters/setters are safer since using the instance variable bypasses any checks or operations performed by the setter.Referencing and setting instance variables using getter and setter methods within the class provides a level of data protection as any small typographical error in the instance variable reference may return a `nil` value **without raising an exception.** 
```ruby 
class Fruit 
  def initialize(type)
    @type = type
  end 

  def say_hello
    "Hello from a friendly #{@typ}"
  end 
end 

apple = Fruit.new('apple')
puts apple.say_hello  #=> Hello from a friendly
```
Conversely, if we made the same spelling mistake while utilizing the getter method to reference the instance variable `@type`, we would have received a useful error message. 
```ruby
class Fruit 
  attr_reader :type 
  
  def initialize(type)
    @type = type
  end 

  def say_hello
    "Hello from a friendly #{typ}"
  end 
end 

apple = Fruit.new('apple')
puts apple.say_hello  #=> Undefined local variable or method 'typ'. 
```
Referencing and setting instance variables through getter and setter methods also allows for greater flexibility in regard to what is being exposed through the public interface. With getter methods, we can hide sensitive information that may be stored in instance variables, while only exposing only necessary data. 
```ruby 
class Customer
  def initialize(id)
    @id = id  # example 12345
  end 

  def my_id
    id
  end 

  private 

  def id
    last_2 = @id.to_s.split('').last(2).join.to_i
    "xxx#{last_2}"
  end 
end 

ned = Customer.new(12345)
puts ned.my_id   #=> xxx45
```
In the above example, the full value referenced by instance variable `@id` is not accessible outside of the class, and the public instance method `my_id` implements a call to the private getter method `id` which applies formatting in order to protect sensitive data. 

- Outside of the class, we do not have a choice, as an object's state is encapsulated within the object and can only be exposed or manipulated outside of the class definition through its public interface (public instance methods). 

# Inheritance 
Inheritance in Ruby is when a subclass inherits behavior from a superclass instead of defining the same method within its own class definition. Inheritance allows for a subclass to exhibit behavior defined in the superclass. Inherited behavior may be implemented in the subclass as it is defined in the superclass, or it may be overridden in the subclass to allow for more mtn_bike behavior. 

Two types of inheritance in Ruby are class inheritance and interface inheritance. Both types of inheritance provide for shared behavior between classes and objects of different types and assist in achieving polymorphism within a program. 

## Class inheritance 
Class inheritance occurs when a subclass inherits behavior from a superclass instead of defining the behavior in the context of its own class definition. Class inheritance is best used when there is a natural hierarchical relationship between classes, for example the superclass and subclass(es) have an "is-a" relationship, where the subclass "is-a" specialized type of the superclass. Classes may only subclass from a single superclass, and through inheritance, have access to all behaviors defined in the parent class. 

```ruby 
class Bicycle
  def ride 
    "I'm riding my #{self.class}"
  end 
end 

class MountainBike < Bicycle ; end 

mtn_bike = MountainBike.new 
puts mtn_bike.ride      # => I'm riding my MountainBike
bike = Bicycle.new
puts bike.ride       #=> I'm riding my Bicycle 

# we are able to call the Bicycle#ride method on mtn_bike due to class inheritance.
```
This code demonstrates the concept of class inheritance as the `MountainBike` class inherits behavior defined in the superclass `Bicycle` without explicitly defining it within the `MountainBike` class. As a result of inheritance, the `mtn_bike` object is able to access all instance methods defined in the parent class. `self`, which is interpolated within the method body of the `Bicycle#ride` method refers to the calling object, and will return the name of the calling object's class. 

This code also demonstrates the concept of polymorphism through inheritance as we are able to invoke the same method on objects of different types, in this case a `Bicycle` object and a `MountainBike` object. As a result, we can utilize the `Bicycle#ride` method polymorphically within the program.

Example: Polymorphism through class inheritance
```ruby 
...omitted code above...

[bike, mtn_bike].each {|object| puts object.ride}

#=> I'm riding my Bicycle
#=> I'm riding my MountainBike
```
In this code, we are not concerned with the class of object calling the method, only that the object's class implements a `ride` method that takes the same number of arguments. Defining behavior in one place and using class inheritance to allow access to the behavior within a subclass allows us to write DRY code that minimizes unnecessary repetition while maintaining intended functionality. 

## Interface inheritance
Interface inheritance occurs when a class inherits behavior that is defined in a module and "mixed-in" to the class using the `include` method and the module name. Interface inheritance provides a way to extend the behavior of objects by extracting behavior shared by two or more classes and making the behavior accessible to objects of each class that mixes in the module. 

Interface inheritance is best utilized when there is not a natural hierarchical relationship among classes, but rather a "has-a" relationship where objects of the class "has-an" ability or behavior that is shared with another class of objects. Interface inheritance is Ruby's way of implementing multiple inheritance, which is not available through class inheritance as a subclass can only inherit from one superclass, but multiple modules. 

```ruby 
module Throwable 
  def throw_ball
    "I'm throwing the ball like a #{self.sport} player."
  end 
end 

class Athlete
  attr_reader :sport

  def initialize(name, sport)
    @name = name 
    @sport = sport
  end 
end 

class BaseballPlayer < Athlete
  include Throwable 
end 

class FootballPlayer < Athlete
  include Throwable 
end 

class Swimmer > Athlete 
  def swim
    "I'm swimming!"
  end 
end 

jeter = BaseballPlayer.new("Jeter", "Baseball")
brady = FootballPlayer.new("Brady", "Football")
phelps = Swimmer.new("Phelps", "Swimmer")
jordan = Athlete.new("Jordan", "Basketball")

puts jeter.throw_ball  # => I'm throwing the ball like a Baseball player.
puts brady.throw_ball  # => I'm throwing the ball like a Football player.

puts phelps.throw_ball # => NoMethod Error
puts jordan.throw_ball # => NoMethod Error
```
In the code above, we defined a module `Throwable` which contains one instance method, `throw_ball`, which returns a string.  We define an `Athlete` class which contains an `initialize` method and two instance variables `@name` and `@sport`. We then have three classes defined `BaseballPlayer`, `FootballPlayer`, and `Swimmer` that subclass from `Athlete`. We mix in the `Throwable` module to the `BaseballPlayer` class and the `FootballPlayer` class. 
We then instantiate an object from each of the four classes and call the `throw_ball` method on each object type. The behavior demonstrates that methods defined in a module must be mixed in to the class in order to be called by objects instantiated from the class. The module was mixed in to the `BaseballPlayer` and `FootballPlayer` classes, but not the `Swimmer` class, meaning we get the expected string output from the two classes that include the `Throwable` module while the `Swimmer` and `Athlete` objects call to the `throw_ball` method raises an exception. 
This code demonstrates the concept of polymorphism through interface inheritance. Object's whose class definitions include a particular module can respond to the same methods defined in the module. 

# Encapsulation
Encapsulation is the concept of hiding data and functionality within the code, and making it unavailable to other parts of the program. Encapsulation allows programmers to create containers for data and provide public access to relevant functionality in an intentional way. Encapsulation is helpful in managing complexity, and allows the program to be structured as an interaction between encapsulated pieces of code rather than relying on numerous procedural dependencies. Encapsulation provides a greater level of data protection and leads to more readable and maintainable code as changes can be made to particular pieces of code without causing cascading effects through the rest of the program. Encapsulation also allows programmers to solve problems at a higher level of abstraction, as objects are modeled after real world nouns and implement methods that are descriptive of intended behavior. 

Ruby implements encapsulation by creating objects and exposing those objects to interfaces which allow them to interact with other objects. Hiding internal representation of an object from the outside, and exposing it selectively through the object's interface (using method access control).

### Examples of encapsulation at work in Ruby: 
```ruby 
class Fish
  def initialize(species, diet)
    @species = species
    @diet = diet
  end 
end 

shark = Fish.new('shark', 'carnivore')
p shark # => #<Fish:0x0000000001569e50 @species="shark", @diet="carnivore">
```
In this code, we define the `Fish` class which contains a constructor method `initialize` which initializes two instance variables `@species` and `@diet`. When we invoke the class method `new` on the `Fish` class, an object is returned, namely, a new instance of the `Fish` class which is assigned to local variable `shark`. The object instantiated encapsulates its own state, which is comprised of it's instance variables and their values. An object's state is unique and the data comprising state is hidden within the object itself, and unavailable to the rest of the program. In order to expose or manipulate information about an object's state, we must provide interfaces (instance methods). The concept of encapsulation is at work here as we are able to encapsulate data within an object, and make decisions about what parts of an object's state should be available to the rest of the program. 

Each class encapsulates its own data — a blueprint of attributes and behaviors— for creating objects. Every newly created object encapsulates its own unique copy of those attributes, but shares the same behaviors as other instances of that class.

# Polymorphism
Polymorphism occurs when objects of different types respond to the same method invocation, often in different ways. When objects of different classes respond to the same method call, they are exhibiting polymorphic behavior. Polymorphism aids in writing DRY code and promotes code flexibility as programmers can define a method in one place and expose objects to the interface in the same way, rather than having to define the same behavior specific to each object type. 

Polymorphism is achieved in Ruby in three ways: 

  - Class inheritance: when one class inherits behavior from another class. 
    ```ruby 
    class Athlete
      def play_sport    # behavior defined in the superclass
        "I'm a #{self.class}, playing my sport!"
      end
    end 

    class BaseballPlayer < Athlete ; end  # subclass inherits behavior

    class FootballPlayer < Athlete ; end  # subclass inherits behavior

    class Swimmer < Athlete               # method overriding
      def play_sport
        "I'm swimming!"
      end
    end 

    judge = BaseballPlayer.new
    brady = FootballPlayer.new
    phelps = Swimmer.new 

    [judge, brady, phelps].each { |obj| puts obj.play_sport } # used polymorphically

    # => 
    # I'm a BaseballPlayer, playing my sport!
    # I'm a FootballPlayer, playing my sport!
    # I'm swimming!
    ```
This code demonstrates polymorphism through class inheritance, as objects of different classes, `BaseballPlayer`, `FootballPlayer`, and `Swimmer`, all respond to the `play_sport` method inherited from the `Athlete`. The `BaseballPlayer` class and the `FootballPlayer` class implement the inherited `play_sport` method as it is defined in the parent class, but generate different return values specific to the calling object type. The `Swimmer` class overrides the inherited `play_sport` method with its own implementation, but we are still able to call `play_sport` on `Swimmer` objects in the same way. 

In order for polymorphism to be present, there must be design intention for polymorphic behavior. Simply inheriting a shared behavior is not polymorphism, as the common interface must be utilized polymorphically in order to achieve polymorphism. In the code above, we are not concerned about the class of object calling the `play_sport` method, only that the calling object can respond to the `play_sport` method (via class inheritance). The example shows polymorphic behavior by passing each object into a block and invoking the `play_sport` method on each object agnostic of class. 

- Interface inheritance: providing shared behavior through mixing in module(s) and allowing objects of the class to respond to the inherited interface defined in the module
    ```ruby 
    module Throwable 
      def throw_ball
        "I'm a #{self.class} throwing the ball!"
      end 
    end 

    class Athlete
      def play_sport    # behavior defined in the superclass
        "I'm a #{self.class}, playing my sport!"
      end
    end 

    class BaseballPlayer < Athlete 
      include Throwable
    end  

    class FootballPlayer < Athlete 
      include Throwable
    end 

    class Swimmer < Athlete             
      def play_sport
        "I'm swimming!"
      end
    end
    
     hank = BaseballPlayer.new
     tom = FootballPlayer.new

     [hank, tom].each { |person| puts person.throw_ball }

     # => I'm a BaseballPlayer throwing the ball!
     # => I'm a FootballPlayer throwing the ball!
    ```
In this code, we define the `throw_ball` method in the module `Throwable` and mix it in to the relevant athletes that should have this behavior. We then call the `throw_ball` method in a way that achieves polymorphic behavior as the `throw_ball` method inherited via the interface provided by the `Throwable` module is invoked the same way on two different object types. Because we are not concerned with the class of object calling the method, and only that the object has a certain behavior, we are able to informally group objects of the class as belonging to a particular group, namely, objects that can throw the ball. This allows for greater reusability and flexibility of code, while eliminating the unnecessary complexity of defining numerous class specific implementation of common behavior. 

- Duck typing
Duck typing is another way to achieve polymorphic behavior in Ruby. Duck typing occurs when objects of different types, unrelated via inheritance, are able to respond to the same method invocation. Duck typing allows programmers to informally group objects as belonging to a select subset of objects that are capable of expressing a particular behavior. Polymorphism through duck typing occurs when we are not concerned about the type of object upon which a method is invoked, or the object's particular implementation of the behavior, only that the objects in play can respond to the same method invocation, called with the same number of arguments. Duck typing showcases one of the benefits of polymorphism as programmers are able to operate at a higher level of abstraction when working with objects of different types by treating them in code as if they are the same object type in regard to responding to a particular interface.
  ```ruby 
  class Fruit 
    def spoil 
      "I'm a #{self.class}, past my expiration date."
    end 
  end 

  class Parent
    def spoil 
      "I'm spoiling my children!"
    end 
  end 

  apple = Fruit.new
  dad = Parent.new

  [apple, dad].each { |obj| puts obj.spoil}
  ```
  In this code, the `Fruit` class and the `Parent` class are unrelated in terms of inheritance structure but we are still able to call the `spoil` method on each object type as if they were the same. We are not worried about what type of object is calling the method, only that the object implements the `spoil` method and takes the same number of arguments when doing so. This allows us to write polymorphic code, and informally group objects from the `Fruit` and `Parent` class as objects that are able to `spoil`. 

# `self` 
`self` is utilized in order to be explicit about what is being referred in the code, and intentions for behavior. The object being referred to by `self` is dependent upon the context of the reference and may be used in the following ways: 

- `self` is used within instance methods to refer to the calling object. 
  ```ruby 
  class Dog 
    attr_accessor :name, :breed 

    def initialize(name, breed)
      @name = name 
      @breed = breed
    end 

    def bark
      "#{self.name} the #{self.breed} says 'woof!'"   # implicit self may be used.
    end 
  ```
- `self` is used to call setter methods from within the class to disambiguate from creating local variables.
  ```ruby 
  class Dog 
    attr_accessor :name, :breed 

    def initialize(name, breed)
      @name = name 
      @breed = breed
    end 

    def change_name(new_name) 
      self.name = new_name         # calling setter method within instance method.
    end 
    ```
- `self`, when referenced within a class but outside of an instance method references the class itself including class method definitions. 
    ```ruby 
    class Dog 
      @@number_of_dogs = 0 

      attr_accessor :name, :breed 

      def initialize(name, breed)
        @name = name
        @breed = breed
        @@number_of_dogs += 1
      end 

      self        # refers to class itself
      
      def self.number_of_dogs      # self used to define class methods
        @@number_of_dogs 
      end 
    end 
    ```
# Modules 
Modules are utilized in Ruby for three significant purposes. 

  - Interface inheritance: when a class does not inherit behavior from another class, but inherits an interface provided by a module being mixed in to the class. Interface inheritance is best utilized when there is a "has-a" relationship between a class and a behavior, for example, a dog "has-an" ability to bark. Interface inheritance through module mix ins allows programmers to extract shared behavior among unrelated classes and define it within a module which can be mixed in to relevant classes. This aids in writing DRY code, as we can define a behavior once in the module, and allow access to the interface through mixing in modules to classes. 

  ```ruby 
  module Throwable 
    def throw_ball
      "I'm throwing the ball"
    end 
  end 

  class Pitcher 
    include Throwable
  end 

  class Quarterback
    include Throwable
  end 

  class Swimmer ; end 
  ```

  - Namespacing is the concept of grouping similar classes and behaviors together within a module in order to better organize code and prevent collisions between classes with the same names within the larger codebase. Namespacing allows programmers to be explicit about which class is being referenced in the program, and aids in maintainability by organizing the code based on a shared characteristic or purpose within the program. We utilize the namespace operator `::` after the name of the module, to access classes defined inside the module. 

  ```ruby 
  module Food
    class Fruit ; end 

    class Vegetable ; end 

    class Grain ; end 
  end 

  apple = Food::Fruit.new 
  ```

  - Module methods are methods defined on the module, and can be invoked on the module directly. Module methods are often behaviors that do not necessarily fit elsewhere in the program design, yet still provide a needed service. 

  ```ruby 
  module Food
    def self.oz_to_cup(oz)
      oz * .125
    end

    class Fruit ; end
    
    ...
  end 
  
  Food.oz_to_cup(8) # => 1
```
# Collaborator Objects 
Collaborator objects refer to objects that are stored within other objects as state. 
  - Can be objects of any type- custom class object, Array, Hash, Integer, String, etc. 
  - Part of another object's state. 
  - Represent connections between various actors in the program.

Collaborator objects may be assigned to an instance variable of another class. 

Example:
```ruby 
class Fruit 
  def initialize(type)
    @type = type 
  end 
end

gala = Fruit.new('apple')
```
In this code, the String object `apple` is a assigned to instance variable `@type` within the constructor method. As a result, the `String` object `"apple"` is a collaborator of the Fruit object `gala`. 


Collaborator objects are not always assigned within the class definition. The class may define instance methods which, when invoked outside the class, add a collaborator object to the state of another. 

```ruby 
class Lunchbox 
  attr_reader :lunch
  
  def initialize 
    @lunch_foods = []
  end 

  def pack_item(item)
    lunch_foods << item
  end 
end 

class Fruit 
  def initialize(type)
    @type = type 
  end 
end 

my_lunch = Lunchbox.new
apple = Fruit.new('apple')
my_lunch.pack_item(apple)
p my_lunch # => [#<Fruit0x00007fd88a5f @type = "apple">]  

# The String object "apple" is a collaborator object of `my_lunch` object. It is stored as state within the `my_lunch` object through its assignment to the @lunch_foods instance variable. 
```
In regard to actual objects in memory, collaboration occurs when one object is added to the state of another object (i.e., when a method is invoked on an object). However, the collaborative relationship exists in the design or intention of the code. 

# Equality/Equivalence
The default `BasicObject#==` method asks the question, are these two objects the same object (do they have the same object id). Each class defines its own `==` method for objects of the class, allowing for the comparison of more useful information. How does the `==` method know what value to use for comparison? It is determined by the class. 

For example, the `String` class defines a `==` method that compares whether or not the string values are the same. 
```ruby 
str = "fish"
abc = "fish" 

str == abc   # => true
str.equal?(abc)  # => false
```
The `BasicObject#equal` method checks to see if the two objects being compared are the same object. 

The flexibility of defining a class specific `==` method allows for the comparison of meaningful values and even the comparison of objects of different types. For most objects, the == operator compares the values of the objects.
```ruby 
integer = 3
float = 3.0 

integer == float    # => true
```
Symbols and Integers behave a bit differently than strings. If two integers or two symbols have the same value, they are also the same object. 

### The `===` method
Used implicitly by case statements. Essentially asks if the calling object is a group, does the argument belong to that group?
```ruby 
String === 'hello'  # => true 
'hello' === String  # => false 
String === 15       # => false 
``` 

### The `eql?` method
Determines if the two objects contain the same value and if they're of the same class. 
This is most often used by `Hash` to determine equality among members, but not used very often. 

# Fake Operators 
https://launchschool.com/lessons/d2f05460/assignments/9a7db2ee

When defining your own custom methods, it is important to consider how the behavior is implemented in the core library. When creating a custom method, it should have predictable behavior based on how it is implemented in other classes. 

### The `<<` method 
The `<<` method is best used when working with a class that represents a collection. 
```ruby 
class Team 
  attr_accessor :name, :members 

  def initialize(name)
    @name = name 
    @members = members 
  end 

  def <<(person)
    members.push(person)  # equivalent to using Array#<< method 
  end 
end 

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end

bulldogs = Team.new("Georgia Bulldogs")
knowshon = Person.new("Knowshon Moreno", 19)

bulldogs << knowshon 

bulldogs.members # => [#<Person:0x0000000001978bb8 @name="Knowshon Moreno", @age=19>]
```

### The plus method
- Integer#+: increments the value by value of the argument, returning a new integer
- String#+: concatenates with argument, returning a new string
- Array#+: concatenates with argument, returning a new array
- Date#+: increments the date in days by value of the argument, returning a new date

### Element setter and getter methods

Element getter method: 
```ruby 
arr = [1, 2, 3]

arr[0] # => getter method, returns 1
arr.[](0) # => same method without syntactical sugar 
```

Element setter method: 
```ruby 
arr = [1, 2, 3]

arr[0] = 5   # => setter method, returns 5 and array is now mutated. 
arr.[]=(0, 5)  # setter method without syntactical sugar
```

In order to use custom element getter and setter methods, we should be working with a class that represents a collection. 

```ruby 
class Team 
# ... omitted code

def [](idx)
  members[idx]   # relying on Array#[]
end 

def []=(idx, obj)
  members[idx] = obj  # relying on Array#[]=
end 

bulldogs.members     # array from previous example

bulldogs[0]     # => #<Person:0x0000000001978bb8 @name="Knowshon Moreno", @age=19>
bulldogs[1] = Person.new("Stetson Bennett", 25)
```

Method	          Operator	                  Description

no	                `., ::`	                Method/constant resolution operators

yes	                `[], []=`	              Collection element getter and setter.

yes	                 `**`	                  Exponential operator

yes	              `!, ~, +, -`	 Not, complement, unary plus and minus (method names for the last two are +@ and -@)

yes	              `*, /, %`	                Multiply, divide, and modulo

yes	                `+, -`	                Plus, minus

yes	                `>>, <<	`              Right and left shift

yes	                  `&`	                   Bitwise "and"

yes                 	`^, |`	       Bitwise exclusive "or" and regular "or" (inclusive "or")

yes	          `<=, <, >, >=`	Less than/equal to, less than, greater than, greater than/equal to

yes	`<=>, ==, ===, !=, =~, !~`	Equality and pattern matching (!~ cannot be directly defined)

no	             `&&`	                    Logical "and"

no	              `||`	                  Logical "or"

no	             `.., ...`	              Inclusive range, exclusive range

no	                `? :`                            Ternary if-then-else

no	`=, %=, /=, -=, +=, |=, &=, >>=, <<=, *=, &&=, ||=, **=, {`	  Assignment (and shortcuts) and block delimiter

