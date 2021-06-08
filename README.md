[Ruby Fundamentals](https://dakotalmartinez.github.io/ruby_fundamentals) | [Object Oriented Ruby](https://dakotalmartinez.github.io/ruby_fundamentals/oo_ruby)
# Object Oriented Ruby

## Key Concepts

### Class

Adding behavior to a class that's already defined in ruby.
```rb
class String
  def say_hello
    puts self
  end
end
```
Classes describe a type of object in ruby.
### Instance

Refers to a particular example of a class (we call an object built by a class an instance)
### Initialize method
```rb
class Dog 
  def initialize(name)
    puts name
  end
end
```
and try to do 
```
Dog.new("Fido")
```
we get an argument error.
### Getter and setter
In javascript we can get and set values on an object with dot notation without defining methods.
In ruby, we actually need to define that interface. If we want to get a dog's name, we need to define a method for that:

```rb
class Dog 
  def initialize(name)
    @name = name
  end

  
  def name 
    @name
  end

  def name=(name)
    @name = name
  end
end
```
### Attribute Macros

```rb
class Dog 
  def initialize(name)
    @name = name
  end

  # attr_accessor :name => defines both of the below methods

  # attr_reader :name => defines this getter method
  def name 
    @name
  end
  # attr_writer :name => defines this setter method
  def name=(name)
    @name = name
  end
end
```
### Instance vs Class Methods
When we are interacting with an instance of a class, we can call instance methods on it.
Instance methods => called on an instance (defined within a class, but not on the class)
Class methods => called on a Class (defined on the class – still within, but we'll look at what this means)

```rb
class Dog 
  def initialize(name)
    @name = name
  end

  # attr_accessor :name => defines both of the below methods

  # attr_reader :name => defines this getter method
  def name 
    @name
  end
  # attr_writer :name => defines this setter method
  def name=(name)
    @name = name
  end
end
```

#### Class methods are defined on the class:

```rb
class Dog
  def self.all 
    puts self # will refer to the Dog class
    @@all
  end

  def name
    puts self # will refer to the instance we invoked .name on
    @name
  end
end
```
### The `self` Keyword
a reference to the receiving object of a method call.
If you see self within a method, it will refer to the object the method was called on.

```rb
class Dog 
  def initialize(name)
    @name = name
  end

  # attr_accessor :name => defines both of the below methods

  # attr_reader :name => defines this getter method
  def name 
    puts self
    @name
  end
  # attr_writer :name => defines this setter method
  def name=(name)
    @name = name
  end
end
```
### Variable Scopes

| Concept | Syntax | Usage |
|---|---|---|
| Instance Scope | @name | used for information that belongs to a single object. Accesible only within an instance (method) |
| Class Scope | @@all | used for information that belongs to a class. Accessible to all instances. |
|  |  |  |

Inside a class method, we can't refer to an instance variable:

```rb
class Dog 
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def self.all 
    name # this is actually equivalent to self.name
  end
end

f = Dog.new("ifod")
Dog.all
```

In ruby, the implicit receiver of any method call is `self`.
If we do `object.method` then `self == object` and inside of our method, any method call without an explicit receiver will be sent to `object` (self)

When you're thinking about using self implicitly within a method. This works for getter methods (when you're retrieving the value of an attribute by invoking a method), but not for setter methods.

Let's take a look at initialize:

```rb
class Dog 
  attr_accessor :name
  def initialize(name)
    self.name = name # this is not the same as self.name = name
  end

  def name=(name)
    @name = name
  end
end
```
Within initialize, `self` refers to the instance being created.

```rb
Dog.new("fido")
```
## Learning Tasks

### Understanding Variable Scope

### Everything in Ruby is An Object – What does this mean?

Even classes are instances of the Class class. 
You can invoke `methods` on any object to see what it knows how to respond to. 

You can invoke `respond_to?` with a symbol argument (method name) to see if that object responds to that method. 

You can invoke `class` on any object to see what class built it and what docs to look at  for reference.

## A note on Initialize

```rb
class Dog
  def initialize(name, age, breed)
    @name = name
    @age = age
    @breed = breed
  end
end

Dog.new("fido", "chihuahua", "8 years")
# we need to know how many arguments to pass, and also what order they need to be in.
```

Instead, you can define initialize to accept a hash of attributes:

```rb
class Dog 
  attr_accessor :name, :age, :breed
  def initialize(attributes)
    @name = attributes[:name]
    @age = attributes[:age]
    @breed = attributes[:breed]
  end
end

Dog.new(name: "fido", breed: "chihuahua",  age: "8 years")
```

If we add additional attributes to the class, we don't need to change our arguments list. 

Why is this important?

If we change the number of arguments that initialize accepts, we have to update all of our calls to Dog.new in the program.

We can also do dynamic assignment of instance variables.

```rb
class Dog 
  attr_accessor :name, :age, :breed
  def initialize(attributes)
    attributes.each do |attribute, value|
      # dynamically call a method (a method that we don't know the name of – because it's stored in a variable – or block parameter in our case)
      # we use the .send method and pass a symbol (or string) matching the name of the method
      puts "#{attribute}="
      self.send("#{attribute}=", value) if self.respond_to?("#{attribute}=")
    end
  end
end
Dog.new(name: "fido", breed: "chihuahua",  age: "8 years")
```

This syntax:

```rb
self.send("#{attribute}=", value) if self.respond_to?("#{attribute}=")

#is equivalent to

if self.respond_to?("#{attribute}=")
  self.send("#{attribute}=", value)
end

# is equivalent to

self.send("#{attribute}=", value) unless !self.respond_to?("#{attribute}=")
```