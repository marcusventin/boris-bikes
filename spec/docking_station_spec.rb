require "docking_station"

describe DockingStation do
  let (:workingbike) { double :bike, working?: true }
  let (:brokenbike) { double :bike, working?: false }

  describe "#initialize" do
    it "has a default capacity" do
      expect( subject.capacity ).to eq described_class::DEFAULT_CAPACITY
    end

    it "allows for a user-generated capacity" do
      station = DockingStation.new(42)
      expect( station.capacity ).to eq 42
    end
  end

  describe "#release_bike" do
    it { is_expected.to respond_to :release_bike }

    it "releases a bike" do
      subject.bikes << workingbike
      expect( subject.release_bike ).to eq workingbike
    end

    it "removes the bike from the docking station" do
      subject.bikes << workingbike
      subject.release_bike
      expect( subject.bikes.include?(workingbike) ).to eq false
    end

    it "raises error when empty" do
      expect { subject.release_bike }.to raise_error( "No bikes left" )
    end

    it "raises error if all bikes are broken" do
      subject.bikes << brokenbike
      expect{ subject.release_bike }.to raise_error( "There are no working bikes at this station" )
    end

    it "doesn't release a broken bike" do
      subject.bikes.push(workingbike, brokenbike)
      expect( subject.release_bike ).to eq workingbike
    end
  end


  describe "#dock" do
    it "docks something" do
      expect( subject.dock(workingbike) ).to eq [workingbike]
    end

    it "raises an error when full" do
      subject.capacity.times { subject.bikes << workingbike }
      expect{ subject.dock(workingbike) }.to raise_error("DockingStation full")
    end
  end

end