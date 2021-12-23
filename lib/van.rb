require_relative "docking_station"
require_relative "bike"
require_relative "garage"

class Van
attr_reader :van
  def initialize
    @van = []
  end

  def collect_broken(dockingstation)
    dockingstation.bikes.each { |bike|
      if bike.working? == false
        @van << dockingstation.bikes.delete(bike)
      end
    }
  end

  def drop_off(garage)
    @van.each { |bike| 
      if bike.working? == false
        garage.workshop << @van.delete(bike)
      end
    }
  end

  def collect_working(garage)
    garage.workshop.each { |bike|
      if bike.working? == true
        @van << bike
      end
    }
    garage.workshop.delete_if { |bike| bike.working? == true }
  end

end