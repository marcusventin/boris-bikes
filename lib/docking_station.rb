require_relative "bike"

class DockingStation

  def initialize
    @bikes = []
  end

  def release_bike
    fail "No bikes left" if empty? 
    @bikes.pop
  end

  def dock(bike)
    fail "No space left" if full?
    @bikes << bike
  end

  private

  def full?
    @bikes.length >= 20
  end
  
  def empty?
    @bikes.empty?
  end
  
end
