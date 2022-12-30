### What is output and why? What does this demonstrate about instance variables that differentiates them from local variables?

```ruby 
class Person
  attr_reader :name
  
  def set_name
    @name = 'Bob'
  end 
end

bob = Person.new
p bob.name
```

On line 13, we invoke the `p` method on the return value of `bob.name` which will print `nil` to the screen and return `nil`. The `nil` return value of invoking the getter method `name` on the `bob` object demonstrates a key difference between instance variables and local variables in Ruby. Instance variables have a default value of `nil` until initialized, while local variables cannot be referenced unless initialized, and will generate an error if we try to reference them. 

In the code above, we define a class `Person` which contains an `attr_reader :name` which creates a getter method for the `@name` instance variable. On lines 7-9 we define an instance method `set_name` which sets the value of the `@name` instance variable when invoked. The key concept in this code is that before the `set_name` instance method is run, the instance variable `@name` has `nil` value, which distinguishes it from local variables as we are able to reference the instance variable via the defined getter method `name` and return `nil` rather than an error for undefined local variable.  

###  What is output and why? What does this demonstrate about instance variables?
```ruby
module Swimmable
  def enable_swimming
    @can_swim = true
  end
end 

class Dog
  include Swimmable
  
  def swim
    "swimming!" if @can_swim
  end 
end

teddy = Dog.new
p teddy.swim
```
On line 37 we invoke the `p` method on the return value of `teddy.swim`. This code will print and return `nil` due to the instance variable `@can_swim` never being initialized, thus when the if statement is evaluated on line 32, it evaluates to false and `swimming!` is not returned. This code demonstrates that we can have instance variables within modules and they have a `nil` value until initialized. 

On lines 22-26 we define the module `Swimmable` which includes one instance method `enable_swimming` which initializes an instance variable `@can_swim` to `true` when invoked. Lines 28-34 define the `Dog` class and the `Swimmable` module is mixed in via the `include` method. On lines 31-33 we define the instance method `swim` which returns the string `"swimming!"` if `@can_swim` evaluates to `true`. On line 36 we instantiate a new `Dog` object and assign it to local variable `teddy`. On line 37, we invoke the `swim` method on `teddy` and call the `p` method on the return value of `teddy.swim`. When line 32 executes, `@can_swim` references `nil` because it was never initialized (`enable_swimming` was never invoked). As a result, `nil` is printed to the console and returned. 

### What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above?

```ruby
module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable
  
  def self.sides
    self::SIDES
  end

  def sides
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides
p Square.new.sides
p Square.new.describe_shape
```
The output of this code will be: 
```ruby 
p Square.sides # => 4
p Square.new.sides # => 4
p Square.new.describe_shape # => Error for uninitialized constant.
```

Constants have lexical scope meaning that their scope is determined by the code construct within which they are defined. When resolving constants, Ruby will first search the lexical scope of the reference, if the constant is not found, Ruby will then search the inheritance hierarchy based on the location of the reference. If not found, Ruby will lastly check the top-level scope. If not found, Ruby will throw an error for an uninitialized constant. 

`self` on line 48 is used within an instance method, so it references the calling object. 
`self` on line 55 is prepended to a method name indicating a class method definition, so this `self` refers to the class. The `self` on line 56 also refers to the class. 
`self` on line 60 refers to the calling object as it is located within an instance method. 



# What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods below?
```ruby 
module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."  # self in instance method, calling object
  end
end

class Shape
  include Describable
  
  def self.sides    # self refers to class 
    self::SIDES     # class, because within a class method
  end 

  def sides
    self.class::SIDES     # self inside instance method references calling object
  end 
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides
p Square.new.sides
p Square.new.describe_shape
```

This code will output the following: 
4
4
Error- uninitialized constant `SIDES`.

This code demonstrates the lexical scope of constants, meaning that the code construct within which the constant is initialized, determines where it is available. 

On line 115, we invoke the `p` method on the return value of `Square.sides`. `::sides` is a class method defined in the `Shape` class, which the `Square` class has access to via class inheritance. When the `::sides` method is invoked, Ruby inspects the method lookup path, and finds the method in the `Shape` class and invokes it. Based on the implementation of the method, `self::SIDES` is the same as `Square::SIDES`. Ruby will begin looking to resolve the constant reference in the `Square` class. `SIDES` is not found in the `Square` class, so Ruby looks next to the inheritance hierarchy of `Square` and finds the constant `SIDES` in the `Quadrilateral` class and returns the value `4`. 

On line 116 we instantiate a new `Square` object and call the instance method `sides`. Ruby locates the `sides` method in the `Shape` class and invokes it. Within the `sides` method, `self.class` returns the class of the calling object, which is `Square` in this case, and uses the namespace resolution operator `::` to access the constant `SIDES` within the `Square` class. This will trigger the same behavior as the above example, as Ruby will first search for the constant lexically within the `Square` class, then move up the inheritance hierarchy where it finds the constant `SIDES` initialized in the `Quadrilateral` class and returns its value, `4`. 

On line 117, we instantiate a new `Square` object and invoke the instance method `describe_shape` Ruby navigates the method lookup path and locates the method in the `Describable` module mixed in to the `Shape` class and invokes it. When Ruby attempts to resolve the constant `SIDES` within the `describe_shape` method, it first searches the lexical scope of the reference, which is the `Describable` module. When it doesn't find it there, it returns an error for an uninitialized constant `SIDES`. 

The lookup path for resolving constants in Ruby is as follows:
  - lexical scope
  - inheritance hierarchy 
  - top level


# What is output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of `AnimalClass#+` to be more in line with what we'd expect the method to return?


```ruby 
class AnimalClass
  attr_accessor :name, :animals
  
  def initialize(name)
    @name = name
    @animals = []
  end
  
  def <<(animal)
    animals << animal
  end
  
  def +(other_class)
    temp_animal_class = AnimalClass.new("Temporary Animals")
    temp_animal_class.animals = animals.other_class.animals
    temp_animal_class
  end 
end

class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end 
end

mammals = AnimalClass.new('Mammals')
mammals << Animal.new('Human')
mammals << Animal.new('Dog')
mammals << Animal.new('Cat')

birds = AnimalClass.new('Birds')
birds << Animal.new('Eagle')
birds << Animal.new('Blue Jay')
birds << Animal.new('Penguin')

some_animal_classes = mammals + birds
p some_animal_classes
```

We invoke the `p` method on local variable `some_animal_classes` on line 179. This will return an array of `Animal` objects. When we invoke the `AnimalClass#+` method on line 178, we are concatenating two array objects and returning a new array object. Since the standard implementation of the `+` method is to return a new object of the class within which it was invoked, it would be more in line with expected behavior if it returned a new `AnimalClass` object. We can do this by instantiating a new `AnimalClass` object within the `+` method body, and setting its instance variable `@animals` to reference the concatenated array. When overriding methods in Ruby, it is best practice to implement them in a way that reflects their behavior in the standard library. This will make maintaining the code more straightforward as unexpected behavior will be minimized. 


# We expect the code below to output `”Spartacus weighs 45 lbs and is 24 inches tall.”` Why does our `change_info` method not work as expected?
```ruby 
class GoodDog
  attr_accessor :name, :height, :weight
  
  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    name = n
    height = h
    weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end 
end

sparky = GoodDog.new('Spartacus', '12 inches', '10 lbs')
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info  # => Spartacus weighs 10 lbs and is 12 inches tall.
```

On line 211, we invoke the `puts` method on the return value of calling the instance method `info` on `sparky`. A string is output, which includes interpolated getter methods `name` `weight` and `height`. This code produces unexpected behavior based on the implementation of the `change_info` instance method within the `GoodDog` class. The way that it is currently written is interpreted by Ruby as initialization of local variables, when the intention is to call setter methods in order to change the state of an object. We must use `self` when calling setter methods within instance methods in order to disambiguate from initializing local variables. In order to call the setter methods within the `change_info` method, we would use the following syntax: 
  `self.name = n`
  `self.height = h`
  `self.weight = w`
This would indicate to Ruby that we are indeed invoking setter methods and would produce the expected output. 




# In the code below, we hope to output `'BOB'` on `line 16`. Instead, we raise an error. Why? How could we adjust this code to output `'BOB'`?     
```ruby 
class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def change_name
    name = name.upcase
  end 
end

bob = Person.new('Bob')
p bob.name
bob.change_name
p bob.name
```

This code will produce unexpected output as the body of the `change_name` method initializes a local variable `name` instead of invoking the desired setter method `name=`. In order to output `"BOB"` we would need to use `self.name = name.upcase` in order to change the value referenced by instance variable `@name`. Calling the `change_name` method this way would invoke the setter method `name=` and update the state of the `bob` object by altering the value referenced by instance variable `@name`.



# What does the code below output, and why? What does this demonstrate about class variables, and why we should avoid using class variables when working with inheritance?
        
```ruby 
class Vehicle
  @@wheels = 4
  
  def self.wheels
    @@wheels
  end 
end

p Vehicle.wheels      # 4

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels   # 2
p Vehicle.wheels      # 2

class Car < Vehicle; end

p Vehicle.wheels    # 2
p Motorcycle.wheels # 2
p Car.wheels        # 2
```

The output of this code is indicated in comments above.
This demonstrates the problematic behavior that may occur as a result of using class variables when working with inheritance. Class variables differ from instance variables in that there is one copy of the class variable shared among all instances of the class and all subclasses. This means that a class variable may be changed within a subclass, and that change would be evident across the entire inheritance hierarchy. Instance methods can also access class variables, and can make alterations that are evident throughout the class hierarchy as well. 



# What is output and why? What does this demonstrate about `super`?
```ruby
class Animal
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end 
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end 

bruno = GoodDog.new("brown")
p bruno

``` 

Invoking the `p` method on `bruno` on line 297 will output information about the `GoodDog` object assigned to local variable `bruno`. This will include the class name, as well as exposing the object's instance variables and their values. The unexpected output here is that the `bruno` object's instance variables `@name` and `@color` both reference the string `"brown"`. This is due to the implementation of the `GoodDog#initialize` method, and specifically the way that the `super` keyword handles arguments. 

On line 296 we instantiate a `GoodDog` object and pass in the string `"brown"` as an argument to the `new` method. The class method `new` triggers the constructor method `initialize` within the `GoodDog` class and forwards the argument to the `initialize` method. The `initialize` method on lines 290-293 accepts one argument, and the string `"brown"` is referenced by local variable `color` within the `initialize` method. On line 291 we utilize the keyword `super` in order to access the `initialize` method from the parent class, `Animal`. `super` automatically forwards arguments passed in to the method within which `super` is used, so the string `"brown"` is forwarded to the `Animal#initialize` method and assigned to instance variable `@name`. On line 292, the instance variable `@color` is set to reference local variable `color`, which still points to the string `"brown"`. As a result of this behavior, `bruno` now has two instance variables that point to the same string object `"brown"`.

In order to achieve desired behavior and utilize the parent class `initialize` method, we should adjust the `GoodDog#initialize` method to accept two arguments, `name` and `color`. We would then specify which argument to pass to `super`, rather than relying on the default forwarding behavior. 
```ruby 
def initialize(color, name)
  super(name)
  @color = color
end 
```




# What is output and why? How does this code demonstrate polymorphism?
```ruby 
class Animal
  def eat
    puts "I eat."
  end
end

class Fish < Animal
  def eat
    puts "I eat plankton."
  end
end

class Dog < Animal
  def eat
     puts "I eat kibble."
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Dog.new]

array_of_animals.each do |animal|
  feed_animal(animal)
end
```
This code demonstrates polymorphism through inheritance and method overriding. The `Animal` class defines an instance method `eat` which is inherited by subclasses `Fish` and `Dog`. The `Fish` and `Dog` class both override the inherited `eat` method with their own class specific behavior. On line 336 we define a `feed_animal` method which takes one parameter `animal`. Within the `feed_animal` method body, we invoke the `eat` method on the argument `animal`. 

On line 340 we initialize local variable `array_of_animals` to reference an array whose elements are new instances of the `Animal`, `Fish`, and `Dog` class. 

On lines 342-344 we invoke the `Array#each` method on `array_of_animals` and pass each object into the block and assign it to block parameter `animal`. Within the block, we invoke the `feed_animal` method and pass in each object referenced by `animal` to the method. When `feed_animal` is invoked, the instance method `eat` is called on each object which outputs a string based on the object's implementation of the `eat` method within its class. 

This demonstrates polymorphism as we are not concerned with each class's particular implementation of the `eat` method, only that each is able to respond to the same method call. We are able to pass objects to our `feed_animal` method agnostic of class, as our we are only concerned with each object's ability to respond to a common interface, namely the `eat` instance method. Implementing polymorphic behavior allows us to treat the `Animal`, `Fish` and `Dog` objects as though they were the same object type and group them informally as objects that can eat. 




# We raise an error in the code below. Why? What do `kitty` and `bud` represent in relation to our `Person` object?
```ruby
class Person
  attr_accessor :name, :pets
  
  def initialize(name)
    @name = name
    @pets = []
  end 
end

class Pet
  def jump
    puts "I'm jumping!"
  end
end

class Cat < Pet; end

class Bulldog < Pet; end

bob = Person.new("Robert")
kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud
bob.pets.jump
```

This code will raise an error due to the code on line 384. Here we invoke the getter method `pets` on our `bob` object, which will return an array object. We then attempt to chain the instance method `Pet#jump` to be called on the array object. This will throw a `NoMethod` error as the `Array` class does not define a `jump` method. The logical intention in this case is to invoke the `jump` method on each element of the array returned by `bob.pets`. In order to do this, we must make an adjustment to the code in order to iterate through each element, rather than attempting to invoke the `jump` method on the array object itself. 
```ruby 
bob.pets.each do |pet|
  pet.jump
end 

# => I'm jumping!
# => I'm jumping!
```


# In the code below, we want to compare whether the two objects have the same name. `Line 11` currently returns `false`. How could we return `true` on `line 11`?

## Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` and `alex`'s `@name` instance variables are the same object? How could we prove our case?
```ruby 
class Person
  attr_reader :name
  
  def initialize(name)
    @name = name
  end 
end

al = Person.new('Alexander')
alex = Person.new('Alexander')
p al == alex # => true
```

This code will return `false` when the last line is executed as we are implementing the `BasicObject#==` method when comparing the `al` object with the `alex` object. The default implementation of `==` is to compare whether or not the two objects being compared are the same object. Since `al` and `alex` are both separate instances of the `Person` class, they have different object ids and thus are not the same object. 

In order to achieve desired behavior, we need to define a custom `Person#==` method in order to compare intended values. In this case, we want to compare values referenced by each object's instance variable `@name`. This would be implemented as shown below: 
```ruby 
def ==(other)
  name == other.name   # utilizing String#== here which compares values
end 
```
Now when we call the `==` method on a `Person` object, the value referenced by each object's `@name` instance variable will be compared. 

It does not necessarily indicate that the string objects are the same object based on the way that `==` is implemented in the `String` class, which compares values rather than object ids. We can check this by examining the object id's of each string object referenced by their respective instance variable `@name`. 

`p alex.name.object_id == al.name.object_id` `# => false`

We could also utilize the `BasicObject#equal?` method, which assesses whether or not the two objects being compared are the same object. 

`p alex.name.equal?(al.name)`




# What is output on `lines 14, 15, and 16` and why?
```ruby
class Person
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    "My name is #{name.upcase!}."
  end 
end

bob = Person.new('Bob')
puts bob.name          # => 'Bob'
puts bob               # => My name is BOB
puts bob.name          # => BOB
```

Output is commented above.
This behavior is due to the destructive method `String#upcase!` being called on the return value of the `name` getter method on line 446. The `name` getter method returns the string object `"Bob"` and we call `upcase!` on this string object. Because `upcase!` is a mutating method, the string object `"Bob"` is altered to `"BOB"`. As a result of this mutation, the string referenced by `@name` is altered as well, as mutating methods operate on the object in place, rather than returning a new string object. To fix this, we could simply call `upcase` in the `to_s` method without the `!`.


# Why is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly when trying to set an instance variable within the class? Give an example.

It is preferred to invoke a setter method within the class rather than referencing the instance variable directly as doing so can help avoid typographical errors and introducing bugs by mis-referencing the instance variable without the benefit of an error message. 

Example: 

```ruby 
class Car 
  attr_accessor :color

  def initialize(color)
    @color = color 
  end 

  def change_color(new_color)
    @cooler = new_color   # mistyped instance variable name
  end 
end 

honda = Car.new('grey')
honda.change_color('red')
p honda   #<Car:0x00000000011d9060 @color="grey", @cooler="red">
```
In the above code, their is a misspelling of the `@color` instance variable, and as a result, a new instance variable is initialized as part of the `Car` object's state. This is not the intended behavior, and no error was thrown as this is valid Ruby code. 

Invoking a setter method provides a level of data protection as we access and make changes to instance variables in a way that is moderated by the interface of the setter method, and will throw an error if the name of the setter method is mistyped (assuming the mistyped setter doesn't reference another defined method). 
```ruby 
class Car 
  attr_accessor :color

  def initialize(color)
    @color = color 
  end 

  def change_color(new_color)
    self.cooler = new_color
  end 
end 

honda = Car.new('grey')
honda.change_color('red')

# => change_color': undefined method `cooler=' for #<Car:0x00000000021d13f0 @color="grey"> (NoMethodError)
```
This code throws an error for an undefined setter method, alerting the programmer of the misspelling of the intended setter method, thereby avoiding introduction of subtle bugs into the program. 




# Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.

Defining a getter method within the class definition is useful when we wish to apply some kind of formatting or restriction on what is exposed outside of the class. Manually defining getter methods allows the programmer to reveal information about an object's state with greater control, and can assist in protecting sensitive data. 

Manually defining getter methods may be used when we do not want to expose the entirety of a value assigned to a particular instance variable. For example:
```ruby 
class Customer
  def initialize(name)
    @name = name 
    @credit_card_number = nil 
  end 

  def store_credit_card(number)
    self.credit_card_number = number
  end 

  def credit_card_number
    last_four
  end 

  private
    attr_writer :credit_card_number
    
    def last_four
      @credit_card_number.to_s.split('').last(4).join.to_i
    end 
end 

bob = Customer.new('Bob')

bob.store_credit_card(987654321)
p bob.credit_card_number  # => 4321
```

In the above code, we create a custom getter method `credit_card_number` which only returns the last four digits. As a result, outside of the class, we cannot access the full number at all, protecting sensitive information and revealing only what is needed to be accessed outside of the class. 



# What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every instance variable in our class? Give an example.

The `attr_accessor` method is an accessor method which provides shorthand functionality in creating getter and setter methods for objects instantiated from the class. When public, `attr_accessor` allows for the values of instance variables to be exposed or changed from outside the class definition. This may or may not be the intention, depending on the data in question, and intended functionality. Simply adding an `attr_accessor` for every instance variable provides minimal boundary around what data can be accessed or changed from outside of the class. 

```ruby 
class House
  attr_accessor :street_name, :city, :state

  def initialize(street_name, city, state)
    @street_name = street_name
    @city = city
    @state = state 
  end 
end 

mine = House.new("Janice Dr", "Athens", "GA")
mine.city = "Las Vegas"
p mine   # => #<House:0x000000000278cf88 @street_name="Janice Dr", @city="Las Vegas", @state="GA">
```
In the above code, due to the `attr_accessor` we have access to all of the data included within our `House` object from outside of the class, we can even make changes to the data as shown above. Some data we don't want to expose, or we want to create our own boundaries around which parts to expose, and some data we don't want to allow to be changed without obvious intention. The concept of encapsulation where each object encapsulates its own state, and then we choose as programmers which parts of the state to make available to other parts of the program provides a level of data protection and control that would compromised by adding an `attr_accessor` method for each instance variable. The benefit of encapsulation, is that it gives the programmer agency over the data encapsulated in each object, and design decisions can be made that better reflect intended behavior while minimizing unintentional data manipulation. 






# What is the difference between states and behaviors?

Each object encapsulates its own unique state, whereas behaviors are shared between all instances of the class. State refers to what an object is made of and is comprised of an object's instance variables and their values. Behavior is what an object is capable of doing, and behavior is shared between all instances of the class based on instance methods defined in the class definition. Instance variables are used to keep track of an object's state, and instance methods are behaviors available to objects of the class. 


# What is the difference between instance methods and class methods?

Instance methods are how we interact with objects and perform operations on an object's state. Instance methods are available to all instances of the class from which the object was instantiated and is responsible for object level behavior. Instance methods are the interface through which we interact with objects. We can access information about an object's state through its instance methods, as instance variables are accessible within instance methods without having to be passed in or initialized within the method body. 

Class methods define class level behavior that does not pertain to individual objects and does not deal with state. Class methods allow for defined behaviors to be called directly on the class without having to instantiate any objects. 


# What are collaborator objects, and what is the purpose of using them in OOP? Give an example of how we would work with one.

Collaborator objects allow us to model relationships between objects of different types as collaborator objects are stored within other objects as part of an object's state. Collaborator objects allow for objects to work together in order to achieve a particular objective. 
```ruby 
class BikeShop
  attr_reader :name, :inventory

  def initialize(name)
    @name = name 
    @inventory = []
  end 

  def add_to_inventory(bike)
    inventory << bike
  end 
end 

class Bike 

  def initialize(type)
    @type = type
  end 
end 

hub = BikeShop.new("The Hub")
canyon = Bike.new("Mountain")

hub.add_to_inventory(canyon)

p hub.inventory  # => [#<Bike:0x00000000014e0b00 @type="Mountain">]
```
In this code, the `BikeShop` object `hub` and the `Bike` object `canyon` are collaborator objects, as `hub` stores `canyon` as part of its state, specifically within the array object referenced by instance variable `@inventory`. Collaborator objects allow programmers to model real world associations as it is quite intuitive for bike shops and bikes to work together collaboratively. 




# How and why would we implement a fake operator in a custom class? Give an example.

We would implement a fake operator (which are methods, but Ruby allows them to be used in an operator type manner) in order to implement class specific behavior based on intended functionality. When overriding fake operator methods, it is important to consider their implementation within other classes and model the custom behavior in a predictable manner. 

```ruby 
class Recipe 
  attr_reader :ingredients

  def initialize
    @ingredients = []
  end 

  def <<(ingredient)
    @ingredients << ingredient
  end 

  def [](idx)
    @ingredients[idx]
  end 

  def []=(idx, value)
    @ingredients[idx] = value
  end 
end 

soup = Recipe.new
soup << "carrot"
soup << "stock"
p soup[0]    
p soup[0] = "Fish"
p soup.ingredients
```

# What are the use cases for `self` in Ruby, and how does `self` change based on the scope it is used in? Provide examples.

`self` allows us to be more explicit about what we are referencing and intentions for behavior within a program. `self` changes based on the context of the reference. 

- inside instance method references calling object
- inside class definition, but outside instance method, references the class itself.
- prepended to method definition, indicates class method- references class itself. 
- `self` also used to call setter methods within class, to disambiguate between local variable initialization. 




# What does the below code demonstrate about how instance variables are scoped?
```ruby 
class Person
  def initialize(n)
    @name = n
  end
  
  def get_name
    @name
  end 
end

bob = Person.new('bob')
joe = Person.new('joe')
puts bob.inspect # => #<Person:0x000055e79be5dea8 @name="bob">
puts joe.inspect # => #<Person:0x000055e79be5de58 @name="joe">
p bob.get_name # => "bob"
```
Instance variables are scoped at the object level, and can be accessed within instance methods without being passed in or initialized in the body of the method. Instance variables keep track of the unique state of objects, and state is encapsulated within the object. 

# How do class inheritance and mixing in modules affect instance variable scope? Give an example.

Instance variables and their values are not inherited, while instance methods may be inherited via class or interface inheritance. Within the inherited methods, instance variables may be initialized. If a subclass calls a method inherited from its superclass, and the method initializes an instance variable, then the instance can now access the instance variable and it becomes part of the object's state. The key distinction is that instance variables are not inherited, and are specific to each object, whereas instance methods are shared between all instances of the class. 

```ruby 
class Athlete
  def initialize(name, sport)
    @name = name 
    @sport = sport
  end 
end 

class Swimmer ; end

phelps = Swimmer.new("Michael", "Swimming")
p phelps # => #<Swimmer:0x00000000011384f8 @name="Michael", @sport="Swimming">
```
In the example above, `Swimmer` subclasses `Athlete` and inherits `Athlete#initialize` which initializes two instance variables `@name` and `@sport`. The instance variables themselves are not inherited, but rather the method that happens to initialize instance variables is inherited, and when invoked on the `Swimmer` object, the instance variables are initialized and become part of the `Swimmer` object's state. 

If we override the `initialize` method, the story changes. 
```ruby 
class Athlete
  def initialize(name, sport)
    @name = name 
    @sport = sport
  end 
end 

class Swimmer < Athlete 
  def initialize
  end 
end

phelps = Swimmer.new
p phelps # => #<Swimmer:0x00000000011b53e0>
```

We override the method in the parent class that initializes the instance variables, therefore, none are initialized. 


# How does encapsulation relate to the public interface of a class?

Encapsulation allows for hiding of data within the code, and allows programmer to make decisions about what to expose or allow to be manipulated outside of the class definition. Encapsulation allows for the internal details of objects to be self-contained within the object, and we are able to expose information about the object's state through its public interface. The public interface is how we interact with an object and expose/manipulate its state. 


# When does accidental method overriding occur, and why? Give an example.


# How is Method Access Control implemented in Ruby? Provide examples of when we would use public, protected, and private access modifiers.

# Describe the distinction between modules and classes.


# What is polymorphism and how can we implement polymorphism in Ruby? Provide examples.

Polymorphism is the ability of data of different types to respond to a common interface. In Ruby, polymorphism is achieved through class inheritance, interface inheritance, and duck typing. 




# What is encapsulation, and why is it important in Ruby? Give an example.




# What is returned/output in the code? Why did it make more sense to use a module as a mixin vs. defining a parent class and using class inheritance?
```ruby 
module Walkable
  def walk
    "#{name} #{gait} forward"
  end 
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  private
  
  def gait
    "strolls"
  end 
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  private
  
  def gait
    "saunters"
  end 
end

mike = Person.new("Mike")
p mike.walk
kitty = Cat.new("Kitty")
p kitty.walk
```


# What is Object Oriented Programming, and why was it created? What are the benefits of OOP, and examples of problems it solves?


# What is the relationship between classes and objects in Ruby?


# When should we use class inheritance vs. interface inheritance?



# What is output and returned, and why? What would we need to change so that the last line outputs `”Sir Gallant is speaking.”`?
```ruby 
class Character
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def speak
    "#{@name} is speaking."
  end 
end

class Knight < Character
  def name
    "Sir " + super
  end
end

sir_gallant = Knight.new("Gallant")
p sir_gallant.name
p sir_gallant.speak
```




# What is output and why?
```ruby
class FarmAnimal
  def speak
    "#{self} says "
  end
end

class Sheep < FarmAnimal
  def speak
    super + "baa!"
  end
end

class Lamb < Sheep
  def speak
    super + "baaaaaaa!"
  end
end

class Cow < FarmAnimal
  def speak
    super + "mooooooo!"
  end
end

p Sheep.new.speak
p Lamb.new.speak
p Cow.new.speak
```


# What are the collaborator objects in the above code snippet, and what makes them collaborator objects?
```ruby
class Person
  def initialize(name)
    @name = name
  end 
end

class Cat
  def initialize(name, owner)
    @name = name
    @owner = owner
  end 
end

sara = Person.new("Sara")
fluffy = Cat.new("Fluffy", sara)
```

# What are the scopes of each of the different variables in the above code?
```ruby
class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']
  
  @@total_people = 0
  
  def initialize(name)
    @name = name
  end

  def age 
    @age
  end 
end
```


# The following is a short description of an application that lets a customer place an order for a meal:
 - A meal always has three meal items: a burger, a side, and drink. # - For each meal item, the customer must choose an option.
- The application must compute the total cost of the order.
 1. Identify the nouns and verbs we need in order to model our classes and methods. 
 2. Create an outline in code (a spike) of the structure of this application.
 3. Place methods in the appropriate classes to correspond with various verbs.




# In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix? Which use case would be preferred according to best practices in Ruby, and why?
```ruby 
 class Cat
  attr_accessor :type, :age
  
  def initialize(type) @type = type
    @age =0
  end
  
  def make_one_year_older
    self.age += 1
  end 
end
```


# What is output and why? What does this demonstrate about how methods need to be defined in modules, and why?
```ruby 
module Drivable
  def self.drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
```





# What module/method could we add to the above code snippet to output the desired output on the last 2 lines, and why?
```ruby
class House
  attr_reader :price
  
  def initialize(price)
    @price = price
  end 
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2 # => Home 1 is cheaper
puts "Home 2 is more expensive" if home2 > home1 # => Home 2 is more expensive
```
