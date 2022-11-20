# Now that we have a Walkable module, we are given a new challenge. Apparently some of our users are nobility, and the regular way of walking simply isn't good enough. Nobility need to strut.

# We need a new class Noble that shows the title and name when walk is called:

module Walkable
  def walk
    "#{self} #{gait} forward"
  end
end

class Person
  include Walkable
  
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
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

  def to_s
    name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "runs"
  end
end

# You need to modify the code so that this works:

mike = Person.new("Mike")
puts mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
puts kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
puts flash.walk
# => "Flash runs forward"


class Noble
  include Walkable

  attr_reader :name, :title

  def initialize(name, title)
    @name = name
    @title = title
  end

  def to_s
    "#{title} #{name}"
  end

  def gait
    "struts"
  end

end

byron = Noble.new("Byron", "Lord")
puts byron.walk
# => "Lord Byron struts forward"

# We must have access to both name and title because they are needed for other purposes that we aren't showing here.

puts byron.name
# => "Byron"
puts byron.title
# => "Lord"


# Discussion

# Before we can do anything, we must first decide how we are going to approach this problem. As suggested in the Approach/Algorithm section, the easiest approach involves providing a method that returns the name and title for Nobles, and just the name for regular Persons, Cats, and Cheetahs. A reasonable way to do this is to define an appropriate #to_s method for all 4 classes, and then change Walkable#walk so it calls #to_s on the object.

# So, this is exactly what we do. We define #to_s in all 4 classes, returning just the name in 3 classes, and returning both the title and name in the Noble class. Finally, we tell Walkable#walk to use #to_s to obtain the person's name (or name and title).

# Wait just one minute. How are we doing that? There's no mention of #to_s in Walkable#walk, is there? Actually, there is - it's just hidden. When you perform interpolation on some value in a string, ruby automatically calls #to_s for you. So, #{self} in the string is actually #{self.to_s} in disguise. In the case of a Cat object, this calls Cat#to_s, but in the case of a Noble, it calls Noble#to_s.


# Further Exploration

# This exercise can be solved in a similar manner by using inheritance; a Noble is a Person, and a Cheetah is a Cat, and both Persons and Cats are Animals. What changes would you need to make to this program to establish these relationships and eliminate the two duplicated #to_s methods?

# Is to_s the best way to provide the name and title functionality we needed for this exercise? Might it be better to create either a different name method (or say a new full_name method) that automatically accesses @title and @name? There are tradeoffs with each choice -- they are worth considering.
