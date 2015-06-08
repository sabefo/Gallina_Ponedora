class LayingHen

  attr_accessor :age, :nido

  def initialize
    @age = 0
    @nido = []
  
  end

  # Ages the hen one month, and lays 4 eggs if the hen is older than 3 months
  def age!
    @age += 1
    # puts "age: #{@age}"
    if @age > 3
      # puts "metemos en el nido"
      @nido << Egg.new(0) << Egg.new(0) << Egg.new(0) << Egg.new(0)

    # else
    #   return
    end
  end

  # Returns +true+ if the hen has laid any eggs, +false+ otherwise
  def any_eggs?
    # puts "hay #{nido.length} huevos"
    if @nido.length > 0
      true
    else
      false
    end
  end

  # Returns an Egg if there are any
  # Raises a NoEggsError otherwise
  def pick_an_egg!
    raise NoEggsError, "The hen has not layed any eggs" unless self.any_eggs?
    egg = Egg.new(0)
    @nido.pop
    # egg-picking logic goes here
  end

  # Returns +true+ if the hen can't laid eggs anymore because of its age, +false+ otherwise
  def old?
    if @age > 10
      true
    else
      false
    end
  end

  def increase_hatched_hour(hours)
    @nido.each{|x| x.hatched_hours += hours}
  end
end

class NoEggsError < StandardError
end

class Egg
  # Initializes a new Egg with hatched hours +hatched_hours+

  attr_accessor :hatched_hours
  def initialize(hatched_hours)
    @hatched_hours = hatched_hours
  end

  # Return +true+ if hatched hours is greater than x, +false+ otherwise
  def rotten?
    if hatched_hours > 3
      true
    else
      false
    end
  end
end

hen = LayingHen.new
basket = []
rotten_eggs = 0

hen.age! until hen.any_eggs?

puts "Hen is #{hen.age} months old, its starting to laid eggs."
puts ""

until hen.old?
  # The time we take to pick up the eggs
  hours = rand(5)
  hen.increase_hatched_hour(hours)

  while hen.any_eggs?
    egg = hen.pick_an_egg!

    # puts "entramos"
    if egg.rotten?
      rotten_eggs += 1
    else
      basket << egg
    end
  end

  puts "Month #{hen.age} Report"
  puts "We took #{hours} hour(s) to pick the eggs"
  puts "Eggs in the basket: #{basket.size}"
  puts "Rotten eggs: #{rotten_eggs}"
  puts ""

  # Age the hen another month
  hen.age!
end

puts "The hen is old, she can't laid more eggs!"
puts "The hen laid #{basket.size + rotten_eggs} eggs"
if rotten_eggs == 0
  puts "CONGRATULATIONS NO ROTTEN EGGS" 
else
  puts "We pick to late #{rotten_eggs} eggs so they become rotten"
end