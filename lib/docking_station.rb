require_relative "bike"

class DockingStation
  attr_reader :bikes
  attr_reader :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    fail "No bikes left" if empty?
    if bikes.all? { |bike| bike.working? == false }
      fail "There are no working bikes at this station"
    else
      counter = -1
      loop do
        if bikes[counter].working? == false
          counter -= 1
        else break
        end
      end
      bikes.delete_at(counter)
    end
  end

  def dock(bike)
    fail "No space left" if full?
    @bikes << bike
  end

  private

  def full?
    @bikes.length >= capacity
  end
  
  def empty?
    @bikes.empty?
  end
  
end
