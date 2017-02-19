require_relative "bike"
require_relative "garage"
require_relative "van"
require_relative "bike_container"

class Garage
  include BikeContainer

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
  def fix_bike(bike)
    bike.working = true
  end

end
