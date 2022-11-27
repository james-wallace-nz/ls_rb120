# Polymorphism through inheritance

class Animal
  def move

  end
end

class Fish < Animal
  def move
    puts 'swim'
  end
end

class Cat < Animal
  def move
    puts 'walk'
  end
end

class Sponge < Animal; end
class Coral < Animal; end

animals = [Fish.new, Cat.new, Sponge.new, Coral.new]
animals.each { |animal| animal.move }

# the client code -- the code that uses those objects -- doesn't care what each object is. The only thing it cares about here is that each object in the array has a move method that requires no arguments.

# The interface for this class hierarchy lets us work with all of those types in the same way even though the implementations may be dramatically different. That is polymorphism.

# Sponge and Coral:
# This is polymorphism through inheritance -- instead of providing our own behavior for the move method, we're using inheritance to acquire the behavior of a superclass. In this case, that behavior does nothing, but it could do something else.

# This is a simple example of polymorphism in which two different object types can respond to the same method call simply by overriding a method inherited from a superclass.

# In a sense, overriding methods like this is similar to duck-typing, a concept that we'll meet shortly. However, overriding is generally treated as an aspect of inheritance, so this is polymorphism through inheritance.

# the public interface lets us work with all of these types in the same way even though the implementations can be dramatically different. That is polymorphism in action.

# Duck Typing

# Duck typing occurs when objects of different unrelated types both respond to the same method name. With duck typing, we aren't concerned with the class or type of an object, but we do care whether an object has a particular behavior.

# If an object quacks like a duck, then we can treat it as a duck. As long as the objects involved use the same method name and take the same number of arguments, we can treat the object as belonging to a specific category of objects.

# Duck typing is an informal way to classify or ascribe a type to objects. Classes provide a more formal way to do that.

class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Chef
        preparer.prepare_food(guests)
      when Decorator
        preparer.decorate_place(flowers)
      when Musician
        preparer.prepare_performance(songs)
      end
    end
  end
end

class Chef
  def prepare_food(guests)
    # implementation
  end
end

class Decorator
  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_performance(songs)
    #implementation
  end
end

# The problem with this approach is that the prepare method has too many dependencies. It relies on specific classes and their names. It also needs to know which method it should call on each of the objects, as well as the argument that those methods require. If you change anything within those classes that impacts Wedding#prepare, you need to refactor the method.

# Let's refactor this code to implement polymorphism with duck typing:

class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end

  class Chef
    def prepare_wedding(wedding)
      prepare_food(wedding.guests)
    end

    def prepare_food(guests)
      # implementation
    end
  end

  class Decorator
    def prepare_wedding(wedding)
      decorate_place(wedding.flowers)
    end

    def decorate_place(flowers)
      # implementation
    end
  end

  class Musician
    def prepare_wedding(wedding.songs)
      prepare_performance(songs)
    end

    def method_name
      # implementation
    end
  end
end

# each of the preparer-type classes provides a prepare_wedding method. We still have polymorphism since all of the objects respond to the prepare_wedding method call. If we later need to add another preparer type, we can create another class and implement the prepare_wedding method to perform the appropriate actions.

# Note that merely having two different objects that have a method with the same name and compatible arguments doesn't mean that you have polymorphism. In theory, those methods might be used polymorphically, but that doesn't always make sense.

# Unless you're actually calling the method in a polymorphic manner, you don't have polymorphism. In practice, polymorphic methods are intentionally designed to be polymorphic; if there's no intention, you probably shouldn't use them polymorphically.
