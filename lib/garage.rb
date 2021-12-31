require_relative "bike"

class Garage
  include BikeContainer
  attr_reader :bikes
end