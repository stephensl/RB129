# Object Oriented Programming 
  - Main points 
    - Managing size and complexity
    - Creating containers for data
    - Reducing dependencies 

#

# Encapsulation 
  - Main points 
    - Hiding functionality behind interface
    - Creating boundaries 
    - Objects and interfaces 

  - Benefits 
    - Data protection 
    - Abstraction 
    - Modularity 
  
  ### Example 
  ```ruby 
  class Fruit
    def initialize(name, calories)
      @name = name 
      @calories = calories 
    end 
  end 

  apple = Fruit.new('apple', 10)

  p apple    # => #<Fruit:0x000000010d03c038 @name="apple", @calories=10>
  apple.name # => Error NoMethod name 
  ```

  Object encapsulates its own unique state. In order to expose or manipulate state, we must create interfaces with which to do so. 

```ruby 
  class Fruit 
    attr_reader :name

    def initialize(name, calories)
      @name = name 
      @calories = calories 
    end 
  end 

  apple = Fuit.new('apple', 10)
  apple.name # => 'apple' 
  apple.calories # => Error NoMethod calories 
``` 
  Created a simple getter method for the instance variable `@name`. We are now able to expose information about the object's state from outside of the class, while keeping other information (calories) private and inaccessible. 

  ### Summary 

  Encapsulation allows programmer to make decisions about what information regarding an object's state to expose or allow to be manipulated. 

#

# Polymorphism 

  - Main points 
    - Data of different types respond to common interface
    - Class inheritance, interface inheritance, duck typing 
    - Must be intentional design decision 
  
  - Benefits 
    - Flexibility and code reusability (DRY)
    - Abstraction (informal grouping)
  
## Examples 
### Polymorphism through class inheritance 

```ruby 
class Athlete
  def initialize(name, age)
    @name = name 
    @age = age 
  end 

  def play_sport
    "I am a(n) #{self.class}, playing my sport!"
  end 
end 

class Gymnast < Athlete ; end 

simone = Gymnast.new('Simone', 25)
tom = Athlete.new('Tom', 31)

[simone, tom].each { |object| puts object.play_sport }

# => I am a(n) Gymnast, playing my sport!
# => I am a(n) Athlete, playing my sport!
```

We are able to invoke the `play_sport` method on our `Gymnast` object as well as our `Athlete` object in a polymorphic manner due to class inheritance. We are not concerned with data type, or implementation details for each class, only that the object can respond to the `play_sport` method. 

### Polymorphism through interface inheritance

```ruby 
module Throwable 
  def throw_ball
    "I'm a #{self.class}, throwing the ball!"
  end 
end 

class Athlete
  def initialize(name, age)
    @name = name 
    @age = age 
  end 

  def play_sport
    "I am a(n) #{self.class}, playing my sport!"
  end 
end 

class Gymnast < Athlete ; end 

class FootballPlayer < Athlete
  include Throwable
end 

class BaseballPlayer < Athlete
  include Throwable 
end 

tom = FootballPlayer.new('Tom', 38)
derek = BaseballPlayer.new('Derek', 31)

[tom, derek].each { |obj| puts obj.throw_ball }

# => I'm a FootballPlayer, throwing the ball!
# => I'm a BaseballPlayer, throwing the ball!
```

Able to call `throw_ball` method polymorphically due to interface inheritance from the mixed in module. Again, we are not concerned with specific implementation details of the behavior for each class, only that the object type can respond to the method call. 

### Polymorphism through duck typing 

```ruby 
class BikeRace 
  def set_up(crew_member)
    crew_member.do_job
  end 
end 

class Referee
  def do_job
    "Monitor the course"
  end 
end 

class Mechanic
  def do_job
    "Tune up the bikes"
  end 
end 

twilight = BikeRace.new

[Referee.new, Mechanic.new].each { |member| puts twilight.set_up(member) }

# => Monitor the course
# => Tune up the bikes
```

In this example, we have classes, unrelated by inheritance, that are able to respond to a common interface, `do_job`. The `Referee` and the `Mechanic` both have the ability to do their job, and we can design code polymorphically and informally group the `Referee` and the `Mechanic` as objects that can `do_job`. We are not concerned with the implementation details of each data type, only that they can respond to a common interface. 

# 

# Objects 

Objects are instances of a class that encapsulate state and exhibit shared behavior with respect to its class. Each object has its own unique state, and shared behavior based on the implementation details of its class. 

Instantiation is the workflow of creating an instance of a class, and utilizes the `Class` method `new`, called on the class and returns an object (instance) of the class. 

### Example of instantiating an object 
```ruby 
class Fruit 
  def initialize(name)
    @name = name 
  end 
end 

orange = Fruit.new('orange')
p orange # => #<Fruit:0x000000010c8f4118 @name="orange">
```
In the example above, we instantiate a new `Fruit` object by invoking the `new` method on our `Fruit` class and passing in one argument, the string object `"orange"`. The `new` method triggers the instance method `initialize` and forwards any arguments passed to the `new` method along to the `initialize` method. The `initialize` method is a special constructor method that builds the object when it is instantiated. Within the `initialize` method, the string object `"orange"` is assigned to parameter `name` and in the body of the method, our instance variable `@name` is assigned to `name`, which points to the string object `"orange"`. The return value of the `Fruit.new` method is a new instance of the `Fruit` class. 

# 

# Classes

Classes act as blueprints for objects, in that they determine what objects of the class will be made of (attributes) and what they will be capable of doing (behaviors). Objects instantiated from classes encapsulate their own unique state, which is tracked by the object's instance variables, and has access to shared behaviors defined in the class. Every object is an instance of a class.

When defining classes, we focus on state and behavior. State is specific to each instance of the class and is tracked by the object's instance variables. Behaviors are shared among all instances of the class and are defined as instance methods.

Classes are defined as shown below: 
```ruby 
class Fruit
  (implementation details)
end
``` 

# 

# Modules 

Modules are similare to classes in that they may contain shared behavior, but differ in the fact that we cannot instantiate objects from modules. 

Modules serve three primary functions in Ruby:

### Module Mixins (interface inheritance)
We are able to extend the functionality of classes by mixing in modules which define behaviors relevant to the class. 

```ruby 
module Flyable
  def fly 
    @can_fly = true 
  end 
end 

class Bird 
  include Flyable 
end 

jay = Bird.new 
jay.fly 
p jay   # => #<Bird:0x000001ac2b275b18 @can_fly=true>
```
In the example above, we give the `Bird` object the ability to fly by mixing in the `Flyable` module. However, the `fly` method must be invoked in order to initialize the instance variable `@can_fly`. Simply including the module, but failing to invoke the `fly` method would never initialize the `@can_fly` instance variable, and it would not be added to its state. 

### Namespacing 
Namespacing utilizes modules to organize similar classes in order to reduce likelihood of collisions within the codebase. Namespacing allows for improved organization of code, and enables programmer to reference classes and behaviors with greater specificity. 

```ruby 
module Food 
  class Fruit ; end 

  class Vegetable ; end 

  class Meat ; end 
end 

apple = Food::Fruit.new    # => #<Food::Fruit:0x000000010731fcd8>
```
In the above example, we instantiate a new `Fruit` object, which is nested in the `Food` module. We utilize the namespace resolution operator `::` to access classes contained in the module. 

### Module methods 
Modules may serve as containers for methods that may not fit elsewhere in the codebase, but serve a useful function. These methods may be invoked directly on the module itself.

To define a module method, we prepend `self` to the method definition. `self` in the context of a module, but outside of an instance method, references the module itself. 

```ruby 
module Conversion
  def self.pounds_to_ounces(num)
    num * 16 
  end 
end 

class Freight 
  attr_reader :weight 

  def initialize(weight)
    @weight = weight 
  end 
end

pack = Freight.new(10)

Conversion.pounds_to_ounces(pack.weight)  # => 160 
``` 
We are able to invoke the `Conversion::pounds_to_ounces` method directly on the `Conversion` module in the example above. Module methods do not require instantiation of any objects. 


#


# Instance variables
Instance variables allow us to tie data to objects, and keep track of an object's state. Instance variables are scoped at the object level, and are available to instance methods without being passed in or initialized within the method body. 

Each object has its own set of instance variables which track its unique state. Instance variables are not inherited, though instance methods (which may initialize instance variables) are inherited. 

Instance variables differ from local variables in that they have a default value of `nil` prior to being initialized. Instance variables cannot be referenced directly from outside of the class definition, and exposing or manipulating the values of instance variables must be achieved through a defined interface.


#


# Instance methods 
Instance methods provide an interface for interacting with objects and allow us to expose or manipulate information about an object's state. Instance methods are shared among all instances of the class in which they are defined, and have access to an object's instance variables. Instance methods define behavior for objects


#


# Accessor methods 





