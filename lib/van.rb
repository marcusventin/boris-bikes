require_relative "docking_station"
require_relative "bike"
require_relative "garage"

class Van
  include BikeContainer
  attr_reader :bikes

  def collect_broken(dockingstation)
    dockingstation.broken_bikes.each { |brokenbike|
      bikes << dockingstation.bikes.delete(brokenbike)
    }
  end

  def drop_off(garage)
    broken_bikes.each { |brokenbike|
      garage.bikes << bikes.delete(brokenbike)
    }
  end

  def collect_working(garage)
    garage.working_bikes.each { |workingbike|
      bikes << garage.bikes.delete(workingbike)
    }
  end

  private

  def working_bikes
    bikes.reject { |bike| bike.working? == false }
  end

  def broken_bikes
    bikes.reject { |bike| bike.working? == true }
  end
end