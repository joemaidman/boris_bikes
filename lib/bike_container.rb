module BikeContainer
  DEFAULT_CAPACITY = 20

  attr_reader :capacity, :bikes

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def full?
    bikes.length >= capacity
  end

  def empty?
    bikes.empty?
  end

end
