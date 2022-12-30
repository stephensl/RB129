```ruby 
class Superhero 
  attr_reader :name, :power
  
  def initialize(name, power)
    @name = name 
    @power = power
  end 
  
  def use_powers
    power 
  end 
  
  def exclaim
    "I'm a superhero!"
  end 
end 

batman = Superhero.new('Batman', 'kicky-punches')
storm = Superhero.new('Storm', 'tornado control')
batman.name       # "Batman"
storm.name        # "Storm"
batman.use_powers # "kicky-punches"
storm.use_powers  # "tornado control"
batman.exclaim    # "I'm a superhero!"
storm.exclaim     # "I'm a superhero!"
```

In this code, we define a class `Superhero` which contains three instance methods `initialize`, `use_powers` and `exclaim`. Objects instantiated from the class will have two instance variables, `@name` and `@power` that are assigned to the arguments passed in during instantiation. The class definition is structured in a way that the value assigned to `batman` and `storm` on lines 3 and 4 of the example will be a new instance of the `Superhero` class. The objects are instantiated from the `Superhero` class and have access to shared behaviors defined in the class, but each object has its own unique state. Instance methods are used in order to reveal or change information related to an object's state, and the different return values of instance methods called on each object reflect the unique state of each object. The way in which instance methods are defined may produce the same return value as seen with the `exclaim` method, or the return value may return information about the unique state of the object, as we see when we call the `name` getter method, or the `use_powers` method. Classes define attributes and behavior for objects instantiated from the class, and all objects of the class have access to the defined behaviors, but may produce different return values in exhibiting these behaviors based on the unique nature of each object's state. 



```ruby
class Book
  attr_accessor :title 
  attr_reader :author 
  attr_writer :isbn, :publisher 
  
  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end
end

book = Book.new('Frankenstein', 'mary shelley', 123456789)
```

In this example we define a `Book` class which contains one instance method `initialize` which initializes three instance variables `@title`, `@author` and `@isbn`. On line 9 we instantiate a new `Book` object by calling the class method `new` on the `Book` class and pass in three arguments, two string objects and an integer object. The `new` method triggers the `initialize` method in the `Book` class and the arguments passed into `new` are forwarded to the `initialize` method, where they are assigned to their respective instance variables. The return value of calling the `new` method on the `Book` class is a new instance of `Book`, and is assigned to local variable `book`. 

On line 11 we attempt to access the value referenced by instance variable `@title` by invoking the `title` getter method. Since there is no getter method defined, this code will generate an exception for an undefined method `title`. On line 12 we attempt to call a setter method `title=` on the `book` object, but this will return a `NoMethodError` as well, because we have not defined the setter method `title=` in the class definition. 
We see the same behavior on line 14, as we attempt to invoke the getter method `author` on `book` which will return an exception because the getter method for `@author` is not defined. In order to provide the expected behavior, we must define a getter and setter method for `@title` and a getter method for `@author`. This can be done by invoking the `attr_accessor` method and passing in the symbol `:title` as an argument which will create a getter and setter method in order to expose and change the value assigned to instance variable `@title`. 

The expected behavior of line 15 demonstrates that we do not want to be able to change the value of the instance variable `@author` from outside of the class, thus we do not want to define a setter method here. Instead we can invoke the `attr_reader` method and pass in the symbol `:author` as an argument in order to create a getter method to expose the value of `@author`, while not creating a setter method. 

Based on the expected behavior listed in the example on lines 16 and 17, we do not want to make the `@isbn` instance variable value able to be exposed outside of the class, but we do want to allow functionality to change the value referenced by `@isbn`. In order to provide this functionality we define only a setter method, `isbn=`. This can be achieved using the shorthand `attr_writer` method and passing in the symbol `:isbn` as an argument. 

The expected return values in the example on lines 18 and 19 suggest that we do not want to define a getter method for the instance variable `@publisher` but we do want to define a setter method in order to set the value referenced by `@publisher`. We can invoke the `attr_writer` method and pass in the symbol `:publisher` in order to do so. 

On line 20, we invoke the `p` method and pass in the object `book` as an argument. This code will return the `book` object including the class name, an encoding of the object_id, as well as the object's instance variables and their values. 

This code demonstrates the concept of encapsulation, as objects instantiated from a class encapsulate their own state, which we are able to expose and change based on design decisions in the code. In order to perform operations on an object's state, we utilize instance methods to provide an interface for doing so. This is beneficial as the programmer can decide which parts of an object state to allow to be exposed or changed from outside the class definition, and provides protection for data stored in individual objects by minimizing the possibility of unintended manipulation of data. 



```ruby 
class Student
  attr_accessor :full_name, :student_id

  def initialize(full_name, student_id)
    @full_name = full_name
    @student_id = student_id
  end

  def format_full_name
    formatted_name = full_name.split(' ').map do |name|
      name.capitalize
    end.join(' ')
    self.full_name = formatted_name
  end
end

gwen = Student.new('gwen lucy richards', 123456768)
p gwen.full_name # gwen lucy richards
p gwen.format_full_name # Gwen Lucy Richards
p gwen.full_name # Gwen Lucy Richards
```

In this code, we define a class `Student` which contains two instance methods `initialize` and `format_full_name`. On line 17 in the example, we instantiate a new `Student` object and assign it to local variable `gwen`. The code on line 20 will return `gwen lucy richards` instead of the capitalized `Gwen Lucy Richards` due to the code on line 13. On line 13 we attempt to update the value referenced by instance variable `@full_name` by setting it to reference the formatted version of the string object assigned to `@full_name`. However, when calling setter methods within instance methods, we must use `self` in order to disambiguate from creating local variables. When the code on line 13 is run, Ruby interprets this as creating a local variable `full_name` rather than calling the setter method `full_name=` in order to achieve the expected return value, we must update the code on line 13 to `self.full_name = formatted_name` This will ensure that the setter method `full_name=` is called, and the value referenced by `@full_name` will be changed based on the functionality of the `format_full_name` method. The code on line 19 returns the return value of the `format_full_name` method, which is the value assigned to local variable `full_name`. This does not indicate that the instance variable `@full_name` was changed, as we see when line 20 is executed. 



Method access control allows programmer to enable or restrict access to behavior through the use or access modifiers: `public`, `protected`, and `private`. Method access control demonstrates the concept of encapsulation, as we set boundaries around access to behavior and hide implementation details from other areas of the program. This allows for the programmer to make explicit design decisions regarding the exposure or manipulation of data outside of the class, protecting data from unintentional alterations that may have consequences throughout the program. 

```ruby 
class Celebrity
  attr_reader :name
  
  def initialize(name, net_worth, agent)
    @name = name
    @net_worth = net_worth
    @agent = agent
  end

  def wealthy?
    net_worth > 1_000_000
  end

  def same_agent?(other_celeb)
    agent == other_celeb.agent
  end
  
  protected 
  
  attr_reader :agent 
  
  private 
  
  attr_reader :net_worth
end

snoop = Celebrity.new('Snoop Dogg', 160_000_000, 'Michelle Smith')
martha = Celebrity.new('Martha Stewart', 400_000_000, 'Rich Dobbs')
```

In the code above, I added a public `attr_reader` method and passed in the symbol `:name` to create a getter method for the `@name` instance variable. Based on the expected return values in the example, we want to be able to expose the value of instance variable `@name` from outside of the class as evidenced on line 20 of the example provided. 

I added a `protected` `attr_reader :agent` in order to allow for all instances of the class to access the getter method for `@agent` but making it inaccessible outside of the class definition. This way, the `same_agent?` method will work as expected when it calls the getter method `agent` on the calling object, and compares the string returned to the return value of invoking the `protected` getter method `agent` on the object passed in as an argument to `same_agent?`. 

I made the `net_worth` getter method `private` as it should not be available outside of the class, or by any object other than the calling object. Private methods are only accessible within the class, and can be used to limit access to sensitive information, or data that is not necessary to be exposed outside of the class definition. However, `private` methods may still be accessed from within instance methods as we see in the `wealthy?` method on lines 8-10 in the example provided. 





This code raises an exception for an undefined method `color` when we attempt to invoke the `color` getter method on line 8. Line 9 will raise an exception as well for an undefined method `color=` as we have not defined a setter method to change the value referenced by `@color`. The code on line 10 will raise the same error if invoked due to a missing getter method `color`. 

In order to fix the code, we need to add the relevant getter and setter methods for `@color`. Three ways to do this are: 

Invoking the shorthand `attr_accessor` method and passing in the symbol `:color` would create getter and setter methods of the same name as the symbol passed in as an argument (`color` and `color=`). 

```ruby 
class House
  attr_accessor :color 
  
  def initialize(color)
   @color = color
  end
end

gray_house = House.new('Gray')
p gray_house.color # Gray
p gray_house.color = 'Orange'
p gray_house.color # Orange
```

We can also explicitly define the getter and setter methods within the class definition. 

```ruby 
class House
  def initialize(color)
   @color = color
  end

  def color  # getter method
    @color
  end 

  def color=(new_color)   # setter method
    @color = new_color
  end 
end

gray_house = House.new('Gray')
p gray_house.color # Gray
p gray_house.color = 'Orange'
p gray_house.color # Orange
```

Alternatively, we can use either `attr_reader` or `attr_writer` and pass in the symbol `:color` to create getter and setter methods in order to expose and change the value referenced by instance variable `@color`. 

```ruby 
class House
attr_reader :color
attr_writer :color

  def initialize(color)
   @color = color
  end
end

gray_house = House.new('Gray')
p gray_house.color # Gray
p gray_house.color = 'Orange'
p gray_house.color # Orange
```

Each of these examples will produce the expected behavior. Which one is preferred is best determined by intended behaviors that may be defined in the class and the intended use for the data stored in the instance variable. Explicitly defining getters and setters rather than utilizing `attr*` methods provides increased flexibility to define specific behaviors around exposing or setting values of instance variables. 



```ruby 
module Swimmable
  def swim 
    "I swim"
  end 
end 

class Mammal
  def body_temp
    'We are warm-blooded'
  end

  def habitat
    "We live almost anywhere"
  end

  def been_to_space
    'Not all of us'
  end
end

class Primate < Mammal 
  def trait
    'We have opposable thumbs'
  end

  def habitat
    'We live in tropical forests mostly'
  end
end

class Human < Primate
  include Swimmable
  
  def habitat 
    'We live structures that we built'
  end 
  
  def been_to_space
    "Yes we have!"
  end 
end

class Gorilla < Primate ; end 
  
class Dolphin < Mammal 
  include Swimmable 
  
  def habitat 
    "We live in the ocean"
  end 
end
```

This code makes use of class and interface inheritance by subclasses inheriting behavior from a superclass, and extending functionality of classes by mixing in a module. Class inheritance is utilized to model "is-a" relationships among classes- for example, a `Primate` is a `Mammal`, so inheriting from the `Mammal` class is a logical choice. We use a mix-in module `Swimmable` in order to provide shared behavior only to classes that "have-an" ability to swim. Utilizing class inheritance and modules allows for sharing of code between related classes, or classes that exhibit a particular shared behavior. 



Encapsulation is the concept of hiding pieces of data and functionality and making them unavailable to the rest of the codebase. Encapsulation allows programmers to create containers for data and provide public access to relevant functionality in an intentional way. Encapsulation is helpful in managing complexity, and allows the program to be structured as an interaction between encapsulated pieces of code rather than relying on numerous procedural dependencies. Encapsulation provides a greater level of data protection and leads to more readable and maintainable code as changes can be made to particular pieces of code without causing cascading effects through the rest of the program. Encapsulation also allows programmers to solve problems at a higher level of abstraction, as objects are modeled after real world nouns and implement methods that are descriptive of intended behavior. 

Ruby implements encapsulation by creating objects and exposing those objects to interfaces which allow them to interact with other objects.

In the code example provided, a class `Employee` is defined which encapsulates the attributes and behaviors that instances of the class will have. Each instance of the `Employee` class encapsulates its own unique state, and we use instance methods to expose or change the state of an object. A new `Employee` object is instantiated on line 20 of the code example, and instance variables `@name` and `@ssn` are initialized when the `initialize` method is triggered by the class method `new`. The instance variables are assigned to the arguments passed into the `new` method. At this point, the object encapsulates the data associated with it, namely its state. Some information may be sensitive or not necessary to expose outside of the class, and we can define boundaries around access to the internal state of objects using method access control. On line 15 we invoke the `private` method, and under the `private` method invoke `attr_reader` and pass in symbols `:name` and `:ssn`. This creates private getter methods for these two instance variables, making them inaccessible outside of the class definition. This way, we can expose information in a way that serves the functionality of the program without making sensitive or irrelevant information publicly available. The state of each object is encapsulated within the object, and we utilize shared behaviors in order to intentionally expose or change the state of an object through exposing the object to interfaces. 



This code demonstrates the concept of polymorphism through duck typing as objects of different types, unrelated by inheritance, are able to respond to a common interface. Duck typing allows programmers to informally group objects as belonging to a select subset of objects that are capable of expressing a particular behavior. Polymorphism through duck typing occurs when we are not concerned about the type of object upon which a method is invoked, or the object's particular implementation of the behavior, only that the objects in play can respond to the same method invocation, called with the same number of arguments. Duck typing showcases one of the benefits of polymorphism as programmers are able to operate at a higher level of abstraction when working with objects of different types by treating them in code as if they are the same object type in regard to responding to a particular interface.

Polymorphism is achieved in Ruby through class inheritance, interface inheritance, and duck typing. In order to use code polymorphically there must be design intention or some functional benefit from doing so. 

Class inheritance occurs when a subclass inherits behavior from a superclass instead of defining the behavior in the context of its own class definition. Class inheritance allows subclasses to access the same behavior, and respond to methods defined in its superclass. The subclass may override inherited behaviors in order to achieve specialized behavior specific to the sub-class. Class inheritance is best used when there is a natural hierarchical relationship between classes. 

Interface inheritance occurs when a class inherits behavior that is defined in a module and "mixed-in" to the class using the `include` method and the module name. Interface inheritance is best utilized when there is not a natural hierarchical relationship among classes, but rather a "has-a" relationship where objects of the class "has-an" ability or behavior that is shared with another class of objects. Interface inheritance is Ruby's way of implementing multiple inheritance, which is not available through class inheritance as a subclass can only inherit from one superclass, but multiple modules. 



The problem with this code is that we are utilizing class inheritance in order to offer shared behavior to subclasses of `Athlete` that do not exhibit the behavior. The `Basketballer`, `Footballer` and `Boxer` classes all subclass `Athlete` and therefore have access to behaviors defined in the `Athlete` class. It does not make sense for the `Boxer` class to inherit the `throw_ball` method, as this object type would not exhibit this behavior. 

In order to resolve the issue, we can look at the particular `throw_ball` method, and see that the behavior is not present among all athletes, and would be better defined in a module that can be mixed in to relevant classes in order to provide access to the behavior. There exists a "has-a" relationship between the `Basketballer` and `Footballer` classes as objects of this type "have an" ability to throw a ball. This indication is useful for determining that interface inheritance via a module is best suited for this example. 
```ruby 
module Throwable
  def throw_ball
    puts "I throw a ball!"
  end
end 

class Athlete; end

class Basketballer < Athlete
end

class Footballer < Athlete
end

class Boxer < Athlete
  def throw_punch
    puts "I throw a punch!"
  end
end

Basketballer.new.throw_ball # I throw a ball!
Footballer.new.throw_ball   # I throw a ball!
Boxer.new.throw_punch       # I throw a punch!
```

Utilizing a mix-in module allows for continued modeling of the "is-a" relationship between the `Boxer` and `Athlete` classes, while removing behavior that is not generalizable across all `Athletes`. 



```ruby 
module LightSpeed
  def drive
    puts "We go fast!"
  end
end

module RidiculousSpeed
  def drive
    puts "We go REAL fast!"
  end
end

module LudicrousSpeed
  def drive
    puts "WE'VE GONE PLAID!"
  end
end

class Spaceship
  def drive
    puts "We go!"
  end
end

class Spaceball < Spaceship
  include LudicrousSpeed
  include LightSpeed
  include RidiculousSpeed
end

spaceball_one = Spaceball.new
spaceball_one.drive
```

This code example contains three module definitions and two class definitions. The class `Spaceship` does not have access to the modules as they are not mixed into the class. The class `Spaceball` inherits from `Spaceship` and also mixes in the three modules `LightSpeed`, `RidiculousSpeed` and `LudicruousSpeed`. 

We instantiate a new `Spaceball` object on line 31 and assign the object to local variable `spaceball_one`. On line 32 we invoke the `drive` method on `spaceball_one`. This code will output the string `We go REAL fast!` and return `nil`. 

The `drive` method invoked on `spaceball_one` is defined in the `RidiculousSpeed` module. The reason it is invoked instead of other `drive` methods accessible via interface inheritance is due to the method lookup path that Ruby inspects when resolving method calls. 

Ruby will first examine the class of the calling object, and if the method is not found, it will examine the mixed-in modules of the class starting with the last module mixed in. If it is not found there, Ruby will continue up the class hierarchy, invoke the method if found, or raise an error if it is not found. 

We can see the method lookup path by invoking the `ancestors` method on the class as shown below. 

```ruby 
p Spaceball.ancestors

# => Spaceball, RidiculousSpeed, LightSpeed, LudicrousSpeed, Spaceship, Object, Kernel, BasicObject]
```


```ruby 
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.fact 
    "Cogito ero sum"
  end 
  
  def rename=(new_name)
    self.name = new_name
  end 

  private

  attr_writer :name
end
```

This code demonstrates the concept that what is being referenced by `self` is dependent on the context in which it is used. The class method `fact` is defined by prepending `self` to the method name, this indicates that we are defining the method on the class. Within the `rename=` method we invoke the setter method `name=` and use `self` to indicate that we are calling a setter method, rather than instantiating a local variable. `self` must be used when invoking private setter methods within instance methods. The code on line 17 of the example is invoking the class method `fact` on the `Person` class, and the class method `Person::fact` is defined using `self` and the method name in order to indicate that we are defining a class method. The code on line 19 is calling a setter method `rename=` and we invoke a private setter method `name=` within the method body. We use `self` in the method body to indicate that we are calling a setter method. 



```ruby 
class Vehicle
end

class LandVehicle < Vehicle
end

class Automobile < LandVehicle
end

class ElectricAutomobile < Automobile
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def ==(other)
    make == other.make && model == other.model 
  end
end

make = 'Tesla'
model = 'Model S'
black_tesla = ElectricAutomobile.new(make, model)
blue_tesla = ElectricAutomobile.new(make, model)

black_tesla == blue_tesla # false
```

The code on line 24 returns false because it is invoking the `BasicObject#==` method when comparing the two objects. The `BasicObject#==` method is implemented in a way that compares whether or not the two objects being compared are the same object, rather than comparing their values. It does not raise an error because the `BasicObject#==` method is available to be called based on class inheritance and the inclusion of `BasicObject` in the method lookup path of the objects being compared. 

In order to compare the values of the objects, we must implement a custom `ElectricAutomobile#==` method in order to specify what we'd like to be compared. In the custom implementation of the method, we compare two string values using the `String#==` method in the body of the `ElectricAutomobile#==` method. This provides a more useful comparison. 