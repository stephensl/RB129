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

  ### Inheritance 




# Classes and Objects 


  ### Instantiation 
  
  ### State 
  
  ### Behavior 

  


# Modules 

  ### Mixins

  ### Namespacing 

  ### Module methods 



# Method lookup path 

  ### Examples with class inheritance 

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

