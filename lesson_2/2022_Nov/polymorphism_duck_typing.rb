class Wedding
  attr_reader :guests, :flowers, :songs, :preparers

  def initialize(guests, flowers, songs)
    @guests = guests
    @flowers = flowers
    @songs = songs
    @preparers = []
  end

  def add_preparer(preparer)
    @preparers << preparer
  end

  def prepare
    @preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(weddding)
    prepare_food(weddding.guests)
  end

  def prepare_food(guests)
    puts "Cook for #{guests.join(', ')}"
  end
end

class Decorator
  def prepare_wedding(weddding)
    decorate_place(weddding.flowers)
  end

  def decorate_place(flowers)
    puts "Decorate with #{flowers.join(', ')}"
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    puts "Prepare #{songs.join(', ')}"
  end
end

class Minister
  def prepare_wedding(wedding)
    prepare_reading(wedding.guests)
  end

  def prepare_reading(guests)
    puts "Dear #{guests.join(' and ')}, we are gathered here today..."
  end
end

wedding = Wedding.new(['James', 'Catherine'], ['roses'], ['aladdin'])
chef = Chef.new
decorator = Decorator.new
musician = Musician.new
minister = Minister.new
wedding.add_preparer(chef)
wedding.add_preparer(decorator)
wedding.add_preparer(musician)
wedding.add_preparer(minister)

wedding.prepare
