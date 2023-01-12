# Why Object Oriented Programming 

Object oriented programming assists in managing the complexity of large software systems. When designing programs, it is important that they be organized and maintainable in a way that facilitates future changes without the need for wholesale restructuring. OOP allows programmers to create containers for code, that can be used as individual building blocks of the program, rather than a web of tightly bound dependencies. This modulation of code allows for the program to become an interaction of building blocks that may be altered without causing disruption to the entire program. OOP utilizes key concepts such as encapsulation, polymorphism, and inheritance to define and structure relationships within the program that achieve the desired functionality. 

OOP may be understood in terms of creating healthy relationships between data, enabling code to evolve and grow over its lifecycle. When pieces of the program are too interdependent, one small change can create a breakdown in functionality and require comprehensive refactoring. Relationships in well designed OO code allow for pieces of code to change in ways that other areas of the program are easily able to adapt to, and change along with it in order to achieve a particular goal. 


# Principles of Object Oriented Programming 
  
  ### Encapsulation 

  Encapsulation is hiding pieces of functionality and making code inaccessible to other parts of the program. Encapsulation involves creating objects, and exposing objects to interfaces in order to interact with them. Encapsulation allows programmers to define boundaries around particular pieces of code and creating interfaces that are intentionally designed to expose only necessary information while keeping other implementation details private. 

  The concept of hiding information behind an interface and making decisions about what data to expose to other objects or the user is encapsulation. For example, objects have "state" which is comprised of its instance variables and their values. Each object has its own unique state which is "encapsulated" within the object. An object's state is private by default, and we are only able to expose or manipulate an object's state through the use of a defined interface. Encapsulation allows non-essential implementation details to be kept private within the object, while allowing for a public interface to access information about the object needed to achieve the intended functionality of the program. 

  Benefits of encapsulation include data protection, maintainability, and abstraction. Encapsulated code cannot be accessed arbitrarily without a defined interface with which to do so. This allows programmers to make decisions about access, and limits the risk of unintentional exposure or manipulation of data. Encapsulation also allows for more maintainable code, as dependencies within the code are limited, and the programmer will be aware of the scope of such changes within the program in regard to its relationship with other parts of the codebase. Encapsulation also allows programmers to work at a higher level of abstraction as objects are represented as real-world nouns, and given methods descriptive of the behavior being represented. 

  Examples of encapsulation: 

  ```ruby 
  class Athlete
    def initialize(name, sport)
      @name = name 
      @sport = sport 
      @id_number = rand(1..100)
    end 
  end 

  mj = Athlete.new("Michael Jordan", "Basketball")
  ```
  At this point in the code, we have defined a class `Athlete` and three attributes, `name`, `sport`, and `id_number`. On line 29, we instantiate a new `Athlete` object and pass in two strings as arguments to the `new` method. The `Athlete` object instantiated is stored in local variable `mj`. `mj` encapsulates its own unique state, and at this point, none of the information encapsulated within the object is accessible. This is clear if we try to access any of the objects instance variables. 

  ```ruby 
  mj.name   # => undefined method 'name'
  mj.@name  # => unexpected instance variable 
  ```

  We must create an interface through which to interact with `mj`. 

  Lets create a way to see `mj`'s name and what sport he plays. 

  ```ruby 
  # code omitted 

  def name 
    @name 
  end 

  def sport 
    @sport 
  end 
  ```

  We created two getter methods. Now we can expose information about `mj`'s state. This could have been achieved using the shorthand `attr_reader :name, :sport` as well, which achieves the same functionality.  

  ```ruby 
  # code omitted

  puts mj.name    # => Michael Jordan 
  puts mj.sport   # => Basketball
  puts mj.id_number # => undefined method `id_number`
  ```

  Getter methods expose the values of instance variables which keep track of an object's state. We can make choices about information accessibility, as we see that `mj`'s `id_number` is still inaccessible because we haven't provided an interface access it. Since we don't want to give access to `id_number` publicly, but we still want to work with the data within the class, we can further demonstrate encapsulation by utilizing method access control. 

  ```ruby 
    class Athlete
      attr_reader :name, :sport

      def initialize(name, sport)
        @name = name 
        @sport = sport 
        @id_number = rand(100..999)
      end 

      def id_last2
        arr = id_number.to_s.split('')
        "*#{arr[-2]}#{arr[-1]}"
      end 

      private 

      attr_reader :id_number 
    end 

  mj = Athlete.new("Michael Jordan", "Basketball")

  puts mj.id_number # => private method id_number
  puts mj.id_last2  # => *37  (shows last two digits of id number)
  ```

  In the above example, we've utilized an access modifier method `private` to prohibit exposure of the value held by instance variable `@id_number`. `mj`'s `id_number` is still inaccessible publicly, and cannot be accessed outside of the class- however, `private` methods are available within the class by the current object so we create a public interface which can access the full `id_number` and make modifications to return only the last two digits, protecting the full number. 

  Data protection can include limiting exposure of sensitive information, as well as prohibiting changes to be made to the state of objects. If we wish to keep certain data private or inaccessible by other parts of the program or to the end user, all we have to do is refrain from creating the relevant interface. 



  ### Polymorphism 

  Polymorphism is ability of data of different types to respond to a common interface. Essentially, polymorphic behavior is present when we invoke the same method call on objects of different classes, and they exhibit behavior (usually) in different ways. Polymorphism allows for code reusability, enabling DRY code, and allows programmer to work on a higher level of abstraction as we are not concerned with the class of the object, or implementation details of the method call, only that it can respond to the method call. In order for polymorphism to be present, code must be written in a polymorphic manner. 

  Polymorphism in Ruby is achieved through 3 main avenues: 

  - Class inheritance 
    - One class inherits behavior of another class (superclass)
    - subclass specializes the superclass 
    - natural hierarchical relationship 

  ```ruby 
  class Athlete
    def play_sport 
      "I'm playing my sport"
    end 
  end 

  class FootballPlayer < Athlete ; end 

  tom = Athlete.new 
  bill = FootballPlayer.new 

  [tom, bill].each { |object| puts object.play_sport }
  ```

  - Interface inheritance 
    - Instead of one class inheriting from another, access shared behavior through mixing in interface
    - Non-hierarchical relationship between classes 
    - Methods defined in modules adn mixed in to relevant classes

  ```ruby 
  module Throwable 
    def throw_ball
      "Throwing the ball!"
    end 
  end 

  class Athlete ; end 

  class FootballPlayer < Athlete
    include Throwable 
  end 

  class BaseballPlayer < Athlete
    include Throwable 
  end 
  
  class Swimmer < Athlete ; end 

  tom = FootballPlayer.new
  derek = BaseballPlayer.new 

  [tom, derek].each { |object| puts object.throw_ball }
  ```
  - Duck typing 
    - When two or more unrelated data types can respond to the same method call
    - Informal way of grouping objects based on ability to respond to common interface
    - Not concerned with object type, only its ability to respond to method call.
    - Behavior is manifested based on definition of method in each class.

  ```ruby 
  class FootballPlayer 
    def throw
      "Throwing the football" 
    end 
  end 

  class Potter 
    def throw 
      "Throwing clay" 
    end 
  end 

  tom = FootballPlayer.new 
  harry = Potter.new 

  [tom, harry].each { |object| puts object.throw}
  ``` 

 
  ### Inheritance 
    - One way to implement polymorphism in Ruby
    - Behaviors can be shared between classes via inheritance. 
      - class inheritance 
      - interface inheritance 




# Classes and Objects 
  - Classes act as blueprints for objects, in that they define what an object of the class will be made of (attributes), and what it will be capable of doing (behaviors). 

  - Objects are instances of classes, and have access to shared behaviors defined in the class
  - Objects encapsulate state: comprised of its instance variables and their values 
  - Each object has shared behavior and unique state. 

  ### Instantiation 
    - Process of creating objects from classes. 
    - Class method `new` is invoked on the class, and a new instance of the class is returned. 
    - `new` triggers the instance method `initialize` if defined in the class. 
  
  ### State 
    - Made up of an object's instance variables and their values 
    - Each object has a unique state.
    - Instance variables keep track of state of individual objects. 
  
  ### Behavior 
    - What objects are capable of (methods available to objects)
    - Behavior is shared among all objects instantiated from a class. 
    - Behavior is inherited from a superclass/module or defined in the class itself. 
    - Objects manifest behavior through instance methods.

  


# Modules 
  Modules perform three basic functions in Ruby. 

  ### Mixins
    - Another way (besides class inheritance) to implement shared behavior.
    - Module may contain methods that extend functionality of classes by mixing the module into relevant classes via the `include` method. 

  ### Namespacing 
    - Way of organizing code
      - Similar classes or methods can be stored in modules 
      - Reduces likelihood of collisions between class or method names in the codebase
  
    ```ruby 
    module Athlete 
      class Swimmer ; end 

      class FootballPlayer ; end 

      class Golfer ; end 
    end 

    tom = Athlete::Swimmer.new 
  ```

  ### Module methods 
    - Methods that may not fit elsewhere in the codebase but still serve important function.
    - Invoked directly on module itself 

    ```ruby 
    module Calculation
      def self.double(num)
        num * 2 
      end 
    end 

    Calculation.double(10)   # => 20 
    ``` 




# Method lookup path 
  - Order in which Ruby seeks to resolve method calls.
  - Generally 
    - class of calling object 
    - any modules mixed in to calling object class (last included to first included)
    - superclass 
    - any modules mixed in to superclass (last included to first included)
    - Object 
    - Kernel
    - BasicObject


  ### Examples with class inheritance 
  
  ```ruby 
    class Athlete
      def play_sport 
        "Playing my sport"
      end 
    end 

    class FootballPlayer < Athlete ; end 

    tom = FootballPlayer.new 

    tom.play_sport # method lookup : [FootballPlayer, Athlete] 
  ``` 

  ### Examples with interface inheritance 



# Instance Variables 

  Instance variables tie data to objects and keep track of the state of individual objects. 
  - Each instance has its own set of instance variables, and unique state. 
  - Instance variables are scoped at the object level and can be accessed within instance methods without being passed in or initialized within the instance method. 
  - Instance variables have a default value of `nil` until initialized



# Instance Methods 

  Instance methods allow us to expose or manipulate an object's state, and provide an interface to interact with objects. 

  Instance methods are able to access instance variables without passing them in or initializing them within the body of the method. Available to all instances of a class and subclasses.




# Accessor Methods 

### Getter 

### Setter 




# `self` 

  `self` allows us to be explicit as to what we are referencing within a program. `self` has multiple meanings depending on the context in which it is used. 

  - `self` prepended to method definition is how we define class methods or module methods. 
  - `self` inside of an instance method references the calling object.
  - `self` inside of a class definition, but outside an instance method references the class itself. 
  - `self` is used to call setter methods within instance methods to disambiguate from creating local       variables. 


# Class Methods 


# Class Variables 

  Class variables keep track of class level information that does not deal with state of individual instances of the class. Class variables are prepended with `@@` and each instance of the class shares one copy of the class variable. 
  
  Scope: class variables are scoped at the class level, and are available within class methods and instance methods. Class variables may be reassigned within instance methods.

  ### Inheritance and Class Variables

    - Avoid class variables when working with inheritance as unexpected behavior may occur as a result of unintentional mutation or reassignment of class variables by subclasses or instances of subclasses. 
    - All instances of the class share one copy of the class variable as well as all subclasses and instances of subclasses. 
    = class variable may be unintentionally reassigned anywhere within the inheritance hierarchy, leading to unexpected behavior as any changes to the class variable within the inheritance hierarchy will be reflected throughout as we are manipulating on the same object referenced by the class variable. 


  ```ruby 
  class Fruit
    @@number_of_fruits = 0 

    def initialize
      @@number_of_fruits += 1
    end 

    def self.number_of_fruits
      @@number_of_fruits
    end 
  end 

  class Apple < Fruit 
    def make_applesauce(num)
      @@number_of_fruits -= num
    end 
  end 

  puts Fruit.number_of_fruits    # => 0 

  apple = Fruit.new 
  pear = Fruit.new 
  fig = Fruit.new 

  puts Fruit.number_of_fruits

  green = Apple.new

  puts Fruit.number_of_fruits

  green.make_applesauce(2)

  puts Fruit.number_of_fruits
  ```



# Constants 
- Information that does not change. 
- Scoped lexically
  - Code construct surrounding the reference determines its availability. 

```ruby 
class Fruit 
  SEEDS = 25 

  def number_of_seeds 
    SEEDS 
  end
  
  def self.number_of_seeds
    SEEDS 
  end 
end

class Apple < Fruit
  SEEDS = 10 
end 

fruit = Fruit.new 
puts fruit.number_of_seeds   # => 25
puts Fruit.number_of_seeds   # => 25

smith = Apple.new
puts smith.number_of_seeds   # => 25 
```

The last line above is telling, as we'd expect that since it is an `Apple` object calling `number_of_seeds` that `10` would be returned, as the constant `SEEDS` references  `10` in the `Apple` class. However, because constants are scoped lexically, and the `number_of_seeds` instance method is utilized via class inheritance, when Ruby resolves the constant `SEEDS` in the body of the `number_of_seeds` method, it searches the lexical scope of the reference, irrespective of the calling object's class. 

In resolving constants, Ruby will first search lexically, then move to the superclass, and finally search the top level scope. Since the reference is located within the `Fruit#number_of_seeds` method, Ruby finds the constant `SEEDS` within the `Fruit` class and returns it. 

# to_s 




# Inheritance 

### Class inheritance 

### Interface inheritance 
  Instead of inheriting behavior from a superclass, the class inherits an interface made available by mixed in module defining the behavior. Interface inheritance is best used when there is not a natural hierarchical relationship, and rather a "has-a" relationship between objects of the class, and the behavior. Interface inheritance allows us to share behavior between classes when there is not a hierarchical relationship which lends itself to class inheritance. Interface inheritance also approximates multiple inheritance in Ruby. Objects cannot be instantiated from modules. 

### Scoping implications 



# `super` keyword

  `super` is used to access methods from earlier in the method lookup path. `super` allows objects to access superclass behavior. 

  ### Arguments and `super` 

  By default `super` will forward all arguments passed in to the method within which `super` is called to the method defined in the superclass. In order to pass no arguments, we use `super()` and we are able to specify which arguments to pass to the superclass method by passing them in as arguments to `super`. 

  ```ruby 
  class Athlete 
    def play_sport
      "I'm playing my sport"
    end 
  end 

  class Golfer < Athlete 
    def play_sport 
      super + ", which is golf."
    end 
  end 

  tiger = Golfer.new
  puts tiger.play_sport   # => I'm playing my sport, which is golf.
  ```

  ```ruby 
  class Student 
    attr_reader :name, :age 

    def initialize(name, age)
      @name = name 
      @age = age 
    end 
  end 

  class LaunchStudent < Student 
    def initialize(name, age, course)
      super(name, age)
      @course = course 
    end 
  end 

  lawton = LaunchStudent.new('Lawton', 34, 'RB129')

  p lawton    # => #<LaunchStudent:0x00000001100683b0 @name="Lawton", @age=34, @course="RB129">
  ```




# Method Access Control 

### Public 

### Private 

### Protected 




# Collaborator Objects 
  Collaborator objects are objects that are stored as part of another object's state. Collaborator objects allow two or more objects to work together in order to accomplish a particular task. Collaborator objects may be of any type, but typically are custom objects. 

  ```ruby 
class Recipe 
  attr_reader :ingredients, :steps
  
  def initialize
    @ingredients = []
    @steps = '' 
  end 

  def add_ingredient(ingredient)
    ingredients << ingredient
  end 

  def print_ingredients 
    ingredients.each { |ingredient| puts ingredient.type }
  end
end 

class Fruit 
  attr_reader :type
  
  def initialize(type)
    @type = type 
  end 
end 

pie = Recipe.new 
apple = Fruit.new('Apple')

pie.add_ingredient(apple)

pie.print_ingredients     # => Apple 

p pie.ingredients      # => [#<Fruit:0x0000000101912ec0 @type="Apple">]
```

The `Recipe` object `pie` and the `Fruit` object `apple` are collaborator objects, as the `Recipe` object stores the `Fruit` object as state within instance variable `@ingredients` in order to accomplish a task of creating a recipe. 


# Equivalence and Fake Operators 

  - `BasicObject#==` asks whether objects being compared are the same object
  - Classes should define their own `==` method to provide more meaningful comparison.






### Resources 

https://medium.com/@marwan.zaarab/rb120-oop-part-1-encapsulation-inheritance-and-polymorphism-179e095d26ba

https://medium.com/@marwan.zaarab/instance-variables-ecb65ffd089f

