# Now that we have a Walkable module, we are given a new challenge. Apparently some of our users are nobility, and the regular way of walking simply isn't good enough. Nobility need to strut.

# We need a new class Noble that shows the title and name when walk is called:

module Walkable
  def walk
    # puts "#{name} #{gait} forward."
    puts "#{self} #{gait} forward."
    # When you perform interpolation on some value in a string, ruby automatically calls #to_s for you. So, #{self} in the string is actually #{self.to_s} in disguise. In the case of a Cat object, this calls Cat#to_s, but in the case of a Noble, it calls Noble#to_s.
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

class Noble
  include Walkable

  attr_reader :title, :name

  def initialize(name, title)
    @name = name
    @title = title
  end

  # def walk
  #   puts "#{title} #{name} #{gait} forward."
  # end

  # def name
  #   "#{title} #{@name}"
  # end

  def to_s
    "#{title} #{name}"
  end

  private

  def gait
    'struts'
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"

# We must have access to both name and title because they are needed for other purposes that we aren't showing here.

# byron.name
# => "Byron"
# byron.title
# => "Lord"
