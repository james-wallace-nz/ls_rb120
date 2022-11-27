# Consider the following code:

class Shelter
  attr_reader :unadopted, :adoptions

  def initialize
    @adoptions = []
    @unadopted = []
  end

  def add_unadopted(pet)
    @unadopted << pet
  end

  def print_unadopted
    puts "The shelter has #{unadopted.size} unadopted pets:"
    puts unadopted
  end

  def adopt(owner, pet)
    # owner.pets << pet
    @unadopted.delete(pet)
    owner.add_pet(pet)
    @adoptions << owner unless @adoptions.include?(owner)
  end

  def print_adoptions
    @adoptions.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      # owner.pets.each do |pet|
      #   puts pet
      # end
      owner.print_pets
      puts
    end
  end
end

class Owner
  # attr_accessor :pets
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    pets.size
  end

  def add_pet(pet)
    self.pets << pet
  end

  def print_pets
    puts pets
  end
end

class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{type} named #{name}"
  end
end

asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new

shelter.add_unadopted(asta)
shelter.add_unadopted(laddie)
shelter.add_unadopted(fluffy)
shelter.add_unadopted(kat)
shelter.add_unadopted(ben)
shelter.add_unadopted(chatterbox)
shelter.add_unadopted(bluebell)

shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts
shelter.print_unadopted

james = Owner.new('James')
shelter.adopt(james, laddie)
shelter.print_adoptions
shelter.print_unadopted

# Write the classes and methods that will be necessary to make this code run, and print the following output:

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.

# The order of the output does not matter, so long as all of the information is presented.