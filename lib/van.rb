require_relative "bike"
require_relative "garage"
require_relative "van"
require_relative "bike_container"

class Van
  include BikeContainer

  def dock(bike)
    raise "Sorry, the van is full." if full?
    @bikes << bike
    bike
  end

  def release_bike
    raise "Sorry, the van is empty!" if empty?
    @bikes.each do |x|
      return @bikes.delete(x) if x.working?
    end
    raise "Sorry, no working bikes available."
  end

  # Takes broken bikes from the docking station given
  def take(docking_station)
    raise "Docking station is empty." if docking_station.bikes.empty?
    broken_bikes = docking_station.bikes.select {|x| !x.working?}
    broken_bikes.each do |y|
      return if full?
      docking_station.bikes.delete(dock(y))
    end
  end

  # Collect working bikes from the garage given
  def collect(garage)
    raise "Garage has no bikes." if garage.bikes.empty?
    working_bikes = garage.bikes.select {|x| x.working?}
    working_bikes.each do |y|
      return if full?
      garage.bikes.delete(dock(y))
    end
  end
  # Delivers broken bikes to a garage given
  def deliver(garage)
    raise "Van has no bikes." if empty?
    broken_bikes = bikes.select {|x| !x.working?}
    raise "Van has no broken bikes." unless broken_bikes.length > 0
    broken_bikes.each do |bike|
      bikes.delete(garage.dock(bike))
    end
  end

  # Delivers working bikes to a docking station given
  def distribute(docking_station)
    raise "Van has no bikes." if empty?
    working_bikes = bikes.select {|x| x.working?}
    raise "Van has no working bikes." unless working_bikes.length > 0
    working_bikes.each do |bike|
      bikes.delete(docking_station.dock(bike))
    end
  end

  private
  def fix_bike(bike)
    bike.working = true
  end

end
