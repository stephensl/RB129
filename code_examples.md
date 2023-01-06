# Accessor Methods

  ## Getter Method
  

Brief summary of understanding of concept or problem. 


If problem provided


  - Examine code aloud 
    - look for: 
      - overall structure of the code in terms of OOP concepts
        - inheritance hierarchy
        - collaborative relationships
        - polymorphic behavior
        - encapsulation, data protection
        - self 

    
  - Examples:                          

  - Identify Bugs

  - Provide solutions



### Returns the values of instance variables. 

```ruby 
class Athlete
  def initialize(name, age)
    @name = name 
    @age = age 
  end 

  def name    
    @name 
  end 

  def age 
    @age
  end 

  def name_and_age
    "My name is #{name} and I am #{age} years old."   # getter method called inside instance method. 
  end 
end 
```
Lines 14-16 define the `name` getter method which exposes the value of instance variable @name. 

The getter method may be called from outside of the class if the getter method is publicly defined. 

```ruby 
# Assuming the class definition above: 

mj = Athlete.new("MJ", 59)

mj.name # => MJ    # getter method called publicly
``` 

### Access 

Getter method may be `public`, `private` or `protected`'




class Athlete
  def play_sport
    "Wahoo!!! I'm playing my sport"
  end 

end 

class FootballPlayer < Athlete
  def play_sport
    "Playing football now." 
  end 
end 

class BasketballPlayer < Athlete
end 

