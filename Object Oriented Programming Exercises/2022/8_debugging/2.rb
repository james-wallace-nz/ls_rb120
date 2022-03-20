# Animal Kingdom

# The code below raises an exception. Examine the error message and alter the code so that it runs without error.

class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super(diet, superpower)
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

# SongBird must call super(diet, superpower) otherwise all arguments to new/initialize will be passed to the parent initialize method. ArgumentError: 3 expected 2.

# Discussion

# On line 37 of our code (line 5 of the above solution), we must explicitly pass diet and superpower to super. These specified arguments are then sent up the method lookup chain to Animal#initialize. If we do not pass the two intended arguments to super on line 37, then all three arguments (diet, superpower, and song) that were passed into SongBird#initialize will be passed up the method lookup chain to the Animal#initialize method. This raises an ArgumentError because Animal#initialize expects two arguments rather than three.

# Review this chapter of Launch School's object oriented programming book if you need a refresher on super.

# Further Exploration

# Is the FlightlessBird#initialize method necessary? Why or why not?

# FlightlessBird initialize is not required becuase it has the same arguments as it's parent Animal class and does nothing new.
# without initialize method in the FlightlessBird class, intantiating a new FlightlessBird will call Animal#initialize up the method chain
