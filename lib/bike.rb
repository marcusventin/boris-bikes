class Bike
  attr_reader :working_status
  
  def initialize
    @working_status = true
  end

  def working?
    working_status
  end

  def report
    @working_status = false
  end
end