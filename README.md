[Ruby Fundamentals](https://dakotalmartinez.github.io/ruby_fundamentals) | [Object Oriented Ruby](https://dakotalmartinez.github.io/ruby_fundamentals/oo_ruby)
# Object Oriented Ruby

## Key Concepts

### Class
examples of built in classes:
- Boolean
- Integer
- Array
- String
- Hash

If we want to find information about any of these types of objects, we can look at the ruby docs for the appropriate class.

A class is a type of object. It allows us to encapsulate the data and behavior that all instances of that class will share.
### Instance

This refers to a particular example of a class. So the class describes the pattern that will be used to create instances and describe what their attributes (variables) are and what behvaiors they can do (methods)

#### Dog example

In JS, we don't need to add methods to access properties of an object, but in ruby we do. Interacting with an object requires a method call. And if the method doesn't exist, we'll get a NoMethodError.

### Initialize method

This is like the constructor method in a JS class. This method runs whenever you invoke `.new` on a class. If you need/want to pass arguments when you invoke `.new`, then you need to define an initialize method.

If we want to be able to do something like:

```rb
f = Dog.new("fido")
```

Then you need something like this:

```rb
class Dog 
  def initialize(name)
    puts name
  end
end
```

But what if we want to keep track of the name over time?

```rb
class Dog 
  def initialize(name)
    puts name
  end

  def name 
    name
  end
end
# what will happen?
f = Dog.new("fido")
f.name
```

We see something like this:

```
2.6.6 :034 > f.name
Traceback (most recent call last):
       16: from (irb):30:in `name'
       15: from (irb):30:in `name'
       14: from (irb):30:in `name'
       13: from (irb):30:in `name'
       12: from (irb):30:in `name'
       11: from (irb):30:in `name'
       10: from (irb):30:in `name'
        9: from (irb):30:in `name'
        8: from (irb):30:in `name'
        7: from (irb):30:in `name'
        6: from (irb):30:in `name'
        5: from (irb):30:in `name'
        4: from (irb):30:in `name'
        3: from (irb):30:in `name'
        2: from (irb):30:in `name'
        1: from (irb):30:in `name'
SystemStackError (stack level too deep)
```
Ruby first looks for a local variable called name, and then if it finds it, will return value. If not, then it will look for a method called name, and invoke that. If there is no explicit receiver (fido.name => fido is the receiver of .name), then ruby will execute the method on `self`.

Since we're already inside of the name method in this case, we're stacking up calls to the `name` method on top of each other. Ruby notices that this is happening and there's no end in sight, so it raises this StackLevelTooDeep error.

## Self Keyword 

A reference to the object receiving a method call. If we invoke `.name` on `f` then within the method, `self` will refer to `f`. So, what's happening with this error is that

```rb
def name 
  name # is equivalent to self.name => this means we're calling the method again from inside of its definition.
end
```

Invoking a method from inside of its definition is called recursion. Whenever you do recursion, you have to have an out. That means, some way that the method won't call itself again when some condition is true.

What we want to do is to have the dog remember its name. To do that, we'll use a new kind of variable called an instance variable.x

```rb
class Dog 
  # floppy ears (true/false)
  def initialize(name)
    @name = name
  end

  def name 
    @name
  end
end
# what will happen?
f = Dog.new("fido")
f.name
```

### Variable Scopes
| Concept | Syntax | Usage |
|---|---|---|
| Local variable scope | name = "Dakota" | use when a variable is only needed within a method |
| instance variable | @name = "Dakota" | use when you want an object to remember something about itself. Accessible within the instance method that defines it and also in other instances called on the same object (instance) |
| class variables | @@all = [] | use when you want to keep track of information related to multiple objects. Class variables are accessible throughout the class including inside of instance methods. Class methods cannot access instance variables |

```rb
class Dog 
  def initialize(name)
    @name = name
  end
  @@name = "Michael"

  def self.get_name
    puts @name
    @@name
  end

  def get_name
    puts @@name
    @name
  end 
end
```

### Getter and setter

If we need to change the value of an attribute we use a setter method (name=).
If we want to retrieve the value of an attribute we use a getter method (name).

```rb
class Dog 
  # floppy ears (true/false)
  def initialize(name)
    @name = name
  end

  def name 
    @name
  end
end
# what will happen?
f = Dog.new("fido")
f.name

```
If we want to rename fido to "old yeller dog", we can do something like this:

```rb
f.name = "old yeller dog"
f
```
We need to actually define a setter method:

```rb
class Dog 
  # floppy ears (true/false)
  def initialize(name)
    @name = name # take in a variable and set as the value for the @name instance variable
  end

  def name 
    @name
  end

  def name=(name)
    @name = name
  end
end
```

This invokes the initialize method:

### Attribute Macros

It could get annoying to have to add multiple attributes here:
If we want to add age and breed, we'd have to do something like this.
```rb
class Dog 
  # rather than doing
  attr_reader :name, :age, :breed
  attr_writer :name, :age, :breed
  # There's another macro called attr_accessor that defines both getter and setter methods for an attribute
  attr_accessor :name, :age, :breed
  def initialize(name, age, breed)
    @name = name # take in a variable and set as the value for the @name instance variable
    @age = age #
    @breed = breed
  end

  # attr_reader :name => generates a getter method called `name` that returns the value of an instance variable @name
  def name 
    @name
  end

  # attr_writer :name => generates a setter method called `name=` that will accept a name as an argument and store its value in an instance variable called @name
  def name=(name)
    @name = name
  end

  def age 
    @age
  end

  def age=(age)
    @age = age
  end

  def breed 
    @breed
  end

  def breed=(breed)
    @breed = breed
  end
end
```

Simplified version:

```rb
class Dog 
  attr_accessor :name, :age, :breed
  def initialize(name, age, breed)
    @name = name
    @age = age
    @breed = breed
  end
end

f = Dog.new("fido", "8 years", "Burmese Mountain Dog")
```
What if we did this instead?
```
f = Dog.new("fido", "Burmese Mountain Dog", "8 years")
```

If we use a hash of attributes instead, we can avoid having to remember the correct order every time we call the method.

```rb
class Dog 
  attr_accessor :name, :age, :breed
  def initialize(attributes)
    binding.pry
    @name = self.name
    @age = self.age
    @breed = self.breed
  end
end

f = Dog.new({name: "fido", age: "8 years", breed: "Burmese Mountain Dog"})
```
We got this:

```
#<Dog:0x00007ff56a97fd30 @name=nil, @age=nil, @breed=nil> 
```

The reason for this is that instance variables always hold `nil` before they get a value. So, you're not going to get an undefined instance variable error, you'll just get `nil` back.

You'll see an error like this if you try to call a method on an instance variable without checking if it exists first:

Undefined method `name' for nil:NilClass

How can we pull out values?

```rb
class Dog 
  attr_accessor :name, :age, :breed
  def initialize(attributes)
    @name = attributes[:name]
    @age = attributes[:age]
    @breed = attributes[:breed]
  end
end

f = Dog.new({name: "fido", breed: "Burmese Mountain Dog", age: "8 years"})

```

### The `self` Keyword

The self keyword is a reference to the receiving object.
self within the initialize method refers to the object being created.

```rb
class Dog 
  attr_accessor :name, :age, :breed
  def initialize(attributes)
    @name = attributes[:name]
    @age = attributes[:age]
    @breed = attributes[:breed]
  end

  def greet
    "Hi my name is #{name}, I'm an #{age} #{breed}."
  end
end

f = Dog.new({name: "fido", breed: "Burmese Mountain Dog", age: "8 year old"})

```

Ruby will read the code inside of the greet method by looking first for variables in scope called, name, and breed. When it doesn't find them, it will look for methods defined on the `self` object with those names. In this case, it'll find them because we defined the 3 attr_accessors.

If you invoke a method without directly (explicitly) calling it on an object, the implicit receiver of the method call will be `self`.

If you call `name` within the method, it will be interpreted as `self.name`. So, we need to know what `self` refers to when we are working on a method.

```rb
f = Dog.new({name: "fido", breed: "Burmese Mountain Dog", age: "8 year old"})
f.greet
```
Inside of the `greet` method, what does self refer to?
Potential answers:
attributes
the new dog (f)
```
lassie = Dog.new({name: "Lassie", breed: "Golden Retriever", age: "7 years old"})
lassie.greet
```
What would `self` be here?
`lassie`
### Instance vs Class Methods

attr_accessors are used to define instance methods. 

| Concept | Syntax | Usage |
|---|---|---|
| Instance Methods | def name | used to define behavior of individual instances. We call instance methods on instances. We define instance methods within classes, but not *on* them. |
| Class Methods | def self.name  | used to define behvaior related to the class itself. We call class methods on classes. We define class methods within classes *and* on them.   |
|  |  |  |

```rb
class Dog 
  puts self
end
```

Example class method:

```rb
class Dog 
  def self.all 
    @@all
  end 
end
```

## Errors

```
f = Dog.new("fido")
Traceback (most recent call last):
        4: from ./bin/console:14:in `<main>'
        3: from (irb):14
        2: from (irb):14:in `new'
        1: from (irb):14:in `initialize'
ArgumentError (wrong number of arguments (given 1, expected 0))
```

Invoking new with arguments requires an initialize method.