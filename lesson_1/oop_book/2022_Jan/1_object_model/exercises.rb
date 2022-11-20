# 1. How do we create an object in Ruby? Give an example of the creation of an object.

class MyClass
end

variable = Class.new
sparky = GoodDog.new


# 2. What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

# A module is a way to group reusable code into one place. We can include that code in our classes using the `include` keyword.

# We include a module within a Class definition

module Animal
end

class GoodDog
  include Animal
end

# Modules are also used as a namespace

module Career
  class Engineer
  end

  class Teacher
  end
end
