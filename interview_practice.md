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

Classes are defined as shown below: 
```ruby 
class Fruit
  (implementation details)
end
``` 

# 

# Modules 






