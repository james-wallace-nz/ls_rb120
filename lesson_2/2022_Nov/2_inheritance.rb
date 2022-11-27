class Pet
  def run
    "running!"
  end

  def jump
    'jumping!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end


  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak
puts teddy.swim

karl = Bulldog.new
puts karl.speak
puts karl.swim


pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

pete.run                # => "running!"
# pete.speak              # => NoMethodError

kitty.run               # => "running!"
kitty.speak             # => "meow!"
# kitty.fetch             # => NoMethodError

dave.speak              # => "bark!"

bud.run                 # => "running!"
bud.swim                # => "can't swim!"

# 3.

              Pet (run, jump)
Cat (speak)                     Dog (speak, swim, fetch)

                                Bulldog (swim)

# 4.

# Method lookup path is the order of (class hierarchy) Classes and Modules that Ruby searches through to find a method to invoke. It is important because the first method it finds with the name will be invoked.
