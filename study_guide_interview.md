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



# Instance Methods 




# Accessor Methods 

### Getter 

### Setter 




# `self` 


# Class Methods 


# Class Variables 


# Constants 


# to_s 




# Inheritance 

### Class inheritance 

### Interface inheritance 

### Scoping implications 



# `super` keyword




# Method Access Control 

### Public 

### Private 

### Protected 




# Collaborator Objects 


# Equivalence and Fake Operators 






### Resources 

https://medium.com/@marwan.zaarab/rb120-oop-part-1-encapsulation-inheritance-and-polymorphism-179e095d26ba

https://medium.com/@marwan.zaarab/instance-variables-ecb65ffd089f

