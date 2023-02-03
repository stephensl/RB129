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

Modules are similar to classes in that they may contain shared behavior, but differ in the fact that we cannot instantiate objects from modules. 

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
Instance methods provide an interface for interacting with objects and allow us to expose or manipulate information about an object's state. Instance methods are shared among all instances of the class in which they are defined, and have access to an object's instance variables. Instance methods define behavior for objects.


#


# Accessor methods 
Accessor methods allow us to set, expose, or change information about an object's state.

### Getter method: exposes value assigned to instance variable
```ruby 
class Fruit 
  attr_reader :type    # shorthand getter method (alternative to below)

  def initialize(type)
    @type = type 
  end

  def type   # Getter method exposes value assigned to @type
    @type
  end 
end 

banana = Fruit.new("Banana")
banana.type  # => Banana
```

### Setter method: set, change value assigned to instance variable.
  Setter methods always return the value that was passed in as an argument, regardless of what else occurs within the method.

```ruby 
class Fruit
  attr_writer :color 

  def initialize(color)
    @color = color 
  end 

  def color 
    @color
  end 

  def color=(new_color)   # Setter
    @color = new_color 
  end 
end 

apple = Fruit.new('green')
apple.color       # => green
apple.color = 'red'   # calling setter method 

# syntactical sugar above is equivalent to apple.color=('red')
``` 

#


# Class Variables 
Class variables are utilized to keep track of class level information that is not specific to a particular instance. Class variables are available to class methods once they have been initialized. Class variables are accessible to all instances  of the class (and subclasses), and each instance shares one copy of the class variable.

Class variables should not be used when utilizing inheritance as changes to class variables will be reflected throughout the class, its instances, the subclass(es) and their instances. 

```ruby 
class Athlete 
  @@headcount = 0 

  def initialize(name)
    @name = name 
    @@headcount += 1
  end 

  def self.headcount 
    @@headcount 
  end 

  def how_many_teammates
    number = @@headcount - 1
    "There are #{number} other members of my team"
  end 
end 

# In the example above we define an `Athlete` class. We include a class variable `@@headcount` that keeps track of the number of athletes that are instantiated from the class. 

puts Athlete.headcount # => 0 

tom = Athlete.new('Tom')
sandy = Athlete.new('Sandy')

puts Athlete.headcount # => 2

puts tom.how_many_teammates # There are 1 other members of my team.
```


# 


# Class Methods 
Class methods are behaviors specific to the class, and do not deal with state of individual objects instantiated from the class. Class methods expose or manipulate class-level information and are invoked on the class itself. Class methods have access to class variables, once initialized, and do not have access to instance variables or methods. 

In the previous example, `Athlete::headcount` is a class method which exposes class level information. 


#


# Constants 
Constants may be defined within a class to represent values that do not change. Constants have a lexical scope, meaning that their availability is determined by the code construct surrounding their initialization. 

When a constant is referenced, Ruby resolves the constant in this order:
  - Lexically
  - Inheritance hierarchy 
  - Top level scope 


```ruby
class Mountain 
  ELEVATION = "Above sea-level"  

  def how_tall
    ELEVATION
  end 
end 

class Rockies < Mountain 
  ELEVATION = "14,000 ft" 
end 

class Cascades < Mountain ; end 

rainier = Cascades.new 
p rainier.how_tall        # => Above sea level
```
This is intuitive as the `Cascades` class does not define an `ELEVATION` constant, so Ruby accesses the one defined in the parent class. 

```ruby
longs = Rockies.new 
p longs.how_tall          # => Above sea level
```

This is less intuitive.. why would this code output the string assigned to `Mountain::ELEVATION` constant when the `Rockies` class defines its own `ELEVATION` constant?

This has to do with lexical scope. When we invoke the `how_tall` method on our    `longs` object, Ruby first searches for the `how_tall` method within the class. It does not find it, so next searches the superclass and invokes it. The reference to `ELEVATION` is within the body of the `how_tall` method defined in the `Mountain` class, and due to lexical scoping rules, Ruby will resolve this constant based on the code construct surrounding the reference (the `Mountain` class). 

We could change this code to force reference the class of the calling object by altering the `how_tall` method defined in the `Mountain` class: 

```ruby 
def how_tall 
  self.class::ELEVATION 
end 
```


# 


# `to_s` method 

`puts` automatically calls `to_s` on its argument to convert the value to a string representation. We can override the `to_s` method to produce useful output relevant to our custom classes. 

```ruby 
class Fruit 
  attr_reader :name, :color 

  def initialize(name, color)
    @name = name 
    @color = color 
  end 

  def to_s
    "I am a(n) #{color} #{name}!"
  end 
end 

apple = Fruit.new('apple', 'green')
puts apple    #=> I am a(n) green apple!
```
We created a custom `to_s` method, which overrides the inherited `Object#to_s` method and returns more useful information relevant to the `Fruit` class.


# 


# `self` 
`self` is utilized in Ruby in order to be explicit about what is being referenced in the program. `self` varies depending on where it is used within the source code. 

Use cases for `self` include:

- Defining class methods or module methods
```ruby 
class Fruit 
  def self.what_am_i  # self prepended to method name
    "I'm a #{self}"   # self inside class method references class
  end 
end 

p Fruit.what_am_i     # => "I'm a Fruit"

module Blendable
  def self.for_smoothie?  # self prepended to method name in module
    "I am #{self}"        # self references the module here
  end 
end

p Blendable.for_smoothie? # => "I am Blendable"
```

- Calling setter methods within the class 
```ruby 
class Fruit 
  attr_reader :color

  def initialize(color)
    @color = color 
  end 

  def change_color(new_color)
    self.color = new_color    # disambiguate from local variable initialization
  end 

  private 

  def color=(new_color)
    @color = new_color
  end
end 

apple = Fruit.new('red')
apple.change_color('green')
p apple.color # => "green"
```

- `self` used within an instance method references the calling object 

- `self` used within a class definition, but outside of an instance method references the class itself. 


# 


# Inheritance
When one class inherits behavior from another. The inheriting class (subclass) inherits from a parent class (superclass). 

Inheritance is utilized to extract common behaviors from classes that share the behavior and move it to a superclass. 

### Class inheritance 
One way that we achieve polymorphism in Ruby, is when instead of defining a behavior within a subclass, we are able to access behavior defined in the superclass. 

```ruby 
class Athlete 
  def play_sport
    "I'm playing my sport like a(n) #{self.class}"
  end 
end 

class BaseballPlayer < Athlete ; end 

tom = Athlete.new

puts tom.play_sport    # => I'm playing my sport like a(n) Athlete

derrick = BaseballPlayer.new

puts derrick.play_sport # => I'm playing my sport like a(n) BaseballPlayer
```
In the example above, instead of explicitly defining a shared behavior (ability to play_sport) in both classes, we access the behavior in the superclass via polymorphism through class inheritance. This is best used if there is a natural hierarchical relationship between classes. In this case, `BaseballPlayer` "is-an" `Athlete` and specializes the `Athlete` class. 

### Interface inheritance 
Interface inheritance is extending the functionality of a class by extracting a shared behavior to a module, and mixing in the module to relevant classes. This is best used when there is not a natural hierarchical relationship between classes, and there exists a "has-a" relationship between the class and the behavior. 

```ruby
module Flyable
  def fly
    "I am flying like a(n) #{self.class}"
  end 
end 

class Bird 
  def eat 
    "I am eating" 
  end
end 

class Eagle < Bird 
  include Flyable
end 

class Hawk < Bird 
  include Flyable 
end 

class Ostrich < Bird ; end 

bald = Eagle.new 
red_tail = Hawk.new
gary = Ostrich.new 

puts bald.fly # => I am flying like a(n) Eagle
puts red_tail.fly # => I am flying like a(n) Hawk
puts gary.fly # => undefined method `fly' for #<Ostrich:0x0000000102bdf0f8> (NoMethodError)
```
In the example above, we the `Eagle`, `Hawk`, and `Ostrich` class all inherit from `Bird`, and have access to the shared behavior `eat`. This relationship is modeled hierarchically as the three specialize the `Bird` class as each maintains an "is-a" relationship with the `Bird` class. However, some `Bird`s can fly, while others cannot. Some `Bird`s "have-an" ability to fly, whereas others do not. In order to provide the functionality only to the relevant classes, while maintaining certain shared behaviors modeled in the hierarchical relationship, is to define a shared behavior `fly` within a module `Flyable` and mixing it in via the `include` method only to the classes that implement the behavior, in this case the `Eagle` and `Hawk` "have-an" ability to `fly` whereas an `Ostrich` does not. 


# 


# `super` 
The keyword `super` is used in order access behavior from earlier in the method lookup path. By calling `super` within an instance method, Ruby searches for the method of the same name within the inheritance hierarchy of the class, and invokes it. 

`super` handles arguments in the following ways: 

- No arguments given in superclass or subclass: 
```ruby 
class Athlete 
  def play_sport 
    "I'm playing my sport" 
  end 
end 

class BaseballPlayer < Athlete 
  def play_sport 
    super + " " + "like a #{self.class}"
  end 
end 

bob = BaseballPlayer.new
puts bob.play_sport  # => I'm playing my sport like a BaseballPlayer
```

- Single argument in superclass method: 
```ruby 
class Athlete
  def initialize(name)
    @name = name 
  end 
end 

class Golfer < Athlete 
  def initialize(name, handicap)
    super(name)
    @handicap = handicap 
  end 
end 

tiger = Golfer.new('Tiger Woods', 1) 

p tiger # => #<Golfer:0x000000010a24fbe8 @name="Tiger Woods", @handicap=1>
```
`super` will, by default, forward all arguments passed to the method from which super is called. In order to only send specific arguments up the method lookup path to the superclass, we must explicitly pass them in to `super` as shown above.

- No arguments in superclass method, but one argument in subclass: 
```ruby 
class Athlete 
  def initialize
    @athletic = true 
  end 
end 

class Gymnast < Athlete 
  def initialize(name, age)
    super()          # use super() to send zero arguments up method lookup path
    @name = name 
    @age = age 
  end 
end 

simone = Gymnast.new('Simone', 25)

p simone # => #<Gymnast:0x0000000109e4bc90 @athletic=true, @name="Simone", @age=25>
```
In this example, we provide two arguments to the `Gymnast#initialize` method. Within the body of the method, we utilize the `super` keyword to access behavior defined in the superclass `initialize` method, and send no arguments to the superclass method by utilizing the `()` following the keyword  `super`. As a result, we see that when the `simone` object is initialized, we still initialize the `@athletic` instance variable via the superclass, while initializing `Gymnast` specific instance variables according to the arguments provided. 


# 


# Method lookup path 
Order in which Ruby inspects classes when resolving a method call. Typically the method lookup path looks like: 
  - calling object's class
  - any modules mixed in to the calling object's class 
  - superclass 
  - any modules mixed in to superclass 
  - `Object`
  - `Kernel`
  - `BasicObject` 

The method lookup path is determined by the inheritance hierarchy and any mixed in modules throughout the path. 

```ruby 
module Kickable 
  def kick_ball 
    "I'm kicking the ball"
  end 
end 

class Athlete 
  def initialize(name, age)
    @name = name 
    @age = age 
  end 

  def play_sport
    "I'm playing my sport" 
  end 
end 

class Swimmer < Athlete 
  def initialize(name, age, specialty)
    super(name, age)
    @specialty = specialty 
  end 
end 

class SoccerPlayer < Athlete
  include Kickable 
end 

pele = SoccerPlayer.new("Pele", 80)

pele.kick_ball # method lookup path: [SoccerPlayer, Kickable] 

pele.play_sport # method lookup path: [SoccerPlayer, Kickable, Athlete]

pele.win_game # method lookup path: [SoccerPlayer, Kickable, Athlete, Object, Kernel, BasicObject]  ## will return NoMethod error.
```


#


# Method Access Control 
Method access control allows us to achieve encapsulation in Ruby by managing the accessibility of methods defined in a class. 

By default, instance methods (besides the `initialize` method) are public, and accessible from within anywhere in the program provided the class name, or object name are known.

```ruby 
class Athlete
  def play_sport 
    "Playing my sport!"
  end 
end 

tom = Athlete.new
puts tom.play_sport # => "Playing my sport" 
```
In the example above, the `play_sport` instance method is public, and therefore we are able to invoke it `tom` outside of the class. 

### Private methods
```ruby 
class Athlete
  def initialize(name)
    @name = name 
  end 

  private 

  attr_reader :name 
end 

tom = Athlete.new('Tom')
puts tom.name   # => private method `name' called for #<Athlete:0x0000000109953e18 @name="Tom"> (NoMethodError)
```
We are unable to invoke the `play_sport` method from outside of the class as it is listed under the access modifier `private` and therefore only accessible within the class definition by the current object. 

In order to utilize `private` methods within the class, we can do the following: 
```ruby 
class Athlete
  def initialize(name)
    @name = name 
  end 

  def introduce_self 
    "Hi, my name is #{name}"
  end

  private 

  attr_reader :name 
end 

tom = Athlete.new('Tom')
puts tom.introduce_self # => Hi, my name is Tom

puts tom.name # => private method `name' called for #<Athlete:0x0000000109953e18 @name="Tom"> (NoMethodError)
```
We can access the `name` getter method from within the class definition, but not outside of it. 

### Protected methods
Methods that are `protected` are similar to `private` methods in that they are not accessible from outside of the class definition, but provide a greater level of accessibility as they are able to be invoked by all instances of the class, not only the current object. `protected` methods may be used when we need to make some sort of comparison of two objects, but the data we are comparing, we'd like to keep encapsulated within the class, not allowing public access. 

```ruby
class Pitcher 
  attr_reader :name 

  def initialize(name, velocity)
    @name = name 
    @velocity = velocity 
  end

  def faster_than?(other)
    velocity > other.velocity # invoking protected method on two instances of class.
  end 

  protected 
  
  attr_reader :velocity 
end 

nolan = Pitcher.new('Nolan', 100)
andy = Pitcher.new('Andy', 85)

puts andy.faster_than?(nolan)  # => false
puts nolan.faster_than?(andy)  # => true 

puts nolan.velocity # => protected method faster_than, NoMethod error.
```


# 


# Collaborator objects
Collaborator objects are objects that are stored as part of another object's state. Collaborator objects work together in order to accomplish a task. When we talk about collaborator objects, we typically mean custom objects, but collaborator objects can be objects of any type. 

```ruby 
class Recipe 
  attr_reader :name, :ingredients 

  def initialize(name)
    @name = name
    @ingredients = []
  end 

  def add_ingredient(ingredient)
    ingredients << ingredient 
  end 

  def print_ingredients 
    "Ingredients for #{name}:"
    ingredients.each { |ingredient| puts ingredient }
  end 

  def total_calories 
    total = 0 
    ingredients.each { |ingredient| total += ingredient.calories }
    "#{name} contains #{total} calories" 
  end 
end 

class Food
  attr_reader :type, :calories 

  def initialize(type, calories)
    @type = type
    @calories = calories
  end 

  def to_s 
    "#{type} with #{calories} calories."
  end 
end 

apple_pie = Recipe.new('Apple Pie')

apple = Food.new('Apple', 10)

apple_pie.add_ingredient(apple)

sugar = Food.new("Sugar", 500)

apple_pie.add_ingredient(sugar)

apple_pie.print_ingredients # => Apple with 10 calories.
                            # => Sugar with 500 calories.  

puts apple_pie.total_calories  # => Apple Pie contains 510 calories
```
In the example above, our `Food` objects `apple` and `sugar` are collaborator objects to `apple_pie` as they are stored within the instance variable `@ingredients` as part of the `Recipe` object's state, and help the recipe to achieve a task. 











  

