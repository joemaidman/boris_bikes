require_relative "bike"

class DockingStation
  DEFAULT_CAPACITY = 20

  attr_reader :capacity, :bikes

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
   raise "Sorry, the dock is empty." if empty?
   @bikes.each do |x|
     return @bikes.delete(x) if x.working?
   end
   raise "Sorry, no working bikes available."
   #@bikes.pop or @bikes.last
  end

  def dock(bike)
    raise "Sorry, the dock is full." if full?
    @bikes << bike
    bike
  end

  private
  def full?
    @bikes.length >= capacity
  end

  def empty?
    @bikes.empty?
  end

end
