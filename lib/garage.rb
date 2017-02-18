class Garage
  DEFAULT_CAPACITY = 20

  attr_reader :capacity, :bikes

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def dock(bike)
    raise "Sorry, the garage is full." if full?

    raise "I only accept broken bikes!" if bike.working?
    fix_bike(bike)
    @bikes << bike
    bike
  end

  def release_bike
    raise "Sorry, the garage is empty!" if empty?

    @bikes.each do |x|
      return @bikes.delete(x) if x.working?
    end
    raise "Sorry, no working bikes available."

  end

  private
  def full?
    @bikes.length >= capacity
  end

  def empty?
    @bikes.empty?
  end

  def fix_bike(bike)
    bike.working = true
  end

end
