class Bike
  attr_writer :working
  def initialize(working = true)
    @working = working
  end

  def working?
    @working
  end

end
