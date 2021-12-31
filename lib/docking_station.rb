require_relative "bike"
require_relative "bike_container"

class DockingStation
  include BikeContainer
  attr_reader :bikes

  def release_bike
    fail "No bikes left" if empty?
    if bikes.all? { |bike| bike.working? == false }
      fail "There are no working bikes at this station"
    else
      bikes.delete working_bikes.pop
    end
  end

  def dock(bike)
    add_bike bike
  end

  private

  def working_bikes
    bikes.reject { |bike| bike.working? == false }
  end
end
