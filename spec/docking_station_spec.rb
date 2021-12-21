require "docking_station"

describe DockingStation do

  describe "#initialize" do
    it "has a default capacity of 20" do
      station = DockingStation.new
      expect( station.capacity ).to eq 20
    end

    it "allows for a user-generated capacity" do
      station = DockingStation.new(42)
      expect( station.capacity ).to eq 42
    end
  end

  describe "#release_bike" do

    let (:bike) { double :bike }
    let (:bike_two) { double :bike }
    
    it { is_expected.to respond_to :release_bike }

    it "releases a bike" do
      allow(bike).to receive(:working?).and_return(true)
      subject.dock(bike)
      expect( subject.release_bike ).to eq bike
    end

    it "removes the bike from the docking station" do
      allow(bike).to receive(:working?).and_return(true)
      subject.dock(bike)
      subject.release_bike
      expect(subject.bikes.include?(bike)).to eq false
    end

    it "raises error when empty" do
      expect { subject.release_bike }.to raise_error("No bikes left")
    end

    it "raises error if all bikes are broken" do
      allow(bike).to receive(:working?).and_return false
      subject.dock(bike)
      expect{ subject.release_bike }.to raise_error("There are no working bikes at this station")
    end

    it "doesn't release a broken bike" do
      allow(bike).to receive(:working?).and_return false
      allow(bike_two).to receive(:working?).and_return true

      subject.dock(bike_two)
      subject.dock(bike)
      expect( subject.release_bike ).to eq bike_two
    end
  end


  describe "#dock" do

    let (:bike) { double :bike }

    it "docks something" do
      expect( subject.dock(:bike)[0] ).to eq :bike
    end

    it "raises an error when full" do
      subject.capacity.times { subject.dock(:bike) }
      expect{ subject.dock(:bike) }.to raise_error("No space left")
    end
  end
end