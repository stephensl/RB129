# Classes 
- Blueprints for objects 
  - What object should be made of (attributes)
  - What object is capable of doing (behaviors)
- Shared characteristics of objects instantiated from class
- Group shared behaviors

# Objects 
- Instance of class
- Contains state and behavior
  - Each object encapsulates its own state
  - Shared behavior based on class 

# Getter methods 
- Expose value of instance variables 
- Beneficial vs referencing instance variable directly
  - Avoid mis-typed references to instance variables 
  - Apply custom formatting

# Setter methods
- Set or change value of instance variables
- Always returns argument passed in
- Use `self` to disambiguate from local var initialization when calling setter method within instance method. 

# Instance methods 
- Interface for interacting with objects
- Perform operations on object's state
- Available to all instance of the class
- Can access instance variables without being passed in

# Class variables 
- Keep track of information specific to class
- Every instance of the class and subclasses share one copy of class variables
- May be accessed within instance methods
- Can be reassigned from within instance methods
- Should not be used with inheritance

# Class methods
- Class level behavior that doesn't pertain to individual objects
- Does not deal with state
- Can be called directly on the class
- Cannot access instance variables or methods directly 

# Constants
- Lexical scope: the code construct and inheritance hierarchy where the constant is defined determines its scope. 
- Constant lookup path 
  - [Lexical, Inheritance, Top Level]
- Can access constants in other classes using `::` 

# Method access control 
- Boundaries for method accessibility 
- Public, Private, Protected
- Demonstrates encapsulation 

# Inheritance 
- Sharing behavior via class or interface inheritance
- Polymorphism 
- DRY code
- Model relationships 

### Class inheritance
- Hierarchical, "is-a" relationship 
- Subclass inherits from superclass
- Subclass specializes superclass

### Interface inheritance
- "Has-a" relationship between object and behavior
- Module mix-ins 
- Extends functionality of objects of class
- Approximates multiple inheritance

# Encapsulation 
- Creating objects and exposing to interfaces
- Creating boundaries around code accessibility 
- Data protection 
- Reduced dependencies
- Managing complexity- small parts
- Abstraction- modeling real world 

# Polymorphism 
- Objects of different types respond to common interface
- DRY code 
- Achieved through 
  - Class inheritance
  - Interface inheritance
  - Duck typing
- Polymorphic design intention must be present

# `self` 
- Used to be explicit about reference in code
- `self` references different things based on the context
  - Inside instance methods: calling object 
  - Inside class definition, outside instance method: class itself
  - Prepended to method name in definition: class itself
- Setter methods inside instance methods: calling object, disambiguate from local variable

# Modules
- Three primary use cases:
  - Mix-ins: interface inheritance through module mix-ins
  - Namespacing: grouping related classes under common namespace
  - Module methods: out of place methods
- Similar to classes, contain shared behavior but cannot instantiate objects

# Collaborator Objects
- Objects stored as part of another object's state
- Can be objects of any type - custom or otherwise 
- Represent connection/collaboration between actors in program 
- Provides a way of modeling relationships between different objects
  - For example, a library has books, so there is an associative relationship between objects of class `Library` and objects of class `Book`.
- Collaborator objects assigned to instance variables of other objects
- May not always be assigned within class definition
  - May be assigned when instance method is called outside the class.
- Objects collaborate with objects of other classes in order to fulfill responsibilities
- Collaboration is an association decision at the design level of the program, implementation details may vary. 
  - For example, a `Library` may contain an array of `Book` objects, the array itself may technically be the collaborator object, but the meaningful association is between the `Library` and `Book` objects. 

# Equality/Equivalence
- By default the `BasicObject#==` method checks if objects being compared are same object
- Classes typically override this method to provide class-specific behavior
- `BasicObject#equal?` compares whether the objects being compared are same object. Should NOT be overridden
- `===` asks whether the argument would be considered part of the "group" of the calling object.

