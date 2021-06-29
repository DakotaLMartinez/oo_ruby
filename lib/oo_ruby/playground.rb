# class Dog 

#   # you can add both setter and getter methods using `attr_accessor :name`
#   # setter method can be added to class using attr_writer :name
#   def name=(name)
#     @name = name
#   end

#   # getter method can be added to class using attr_reader :name
#   def name
#     @name
#   end

#   def age=(age)
#     @age = age
#   end

#   def age 
#     @age
#   end

#   def breed=(breed)
#     @breed = breed
#   end

#   def breed 
#     @breed
#   end
# end

class Dog
  attr_accessor :name, :age, :breed

  @@all = []

  # class method is defined ON the class, called ON the class and self refers TO the class
  def self.all
    puts self
    @@all
  end

  def initialize(name, age)
    self.name = name
    self.age = age
    save # same as self.save
  end

  # instance method is defined withIN the class (not on it), called on and INstance and self refers to that instance
  def save
    puts self
    @@all << self
  end
  
end

dog1 = Dog.new("Porkchop", "2 years")
dog2 = Dog.new("Beef Rib", "13 years")
dog3 = Dog.new("Air Bud", "")