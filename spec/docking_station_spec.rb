require "docking_station"

describe DockingStation do
  
  describe "#release_bike" do
    it { is_expected.to respond_to :release_bike }

    it "releases a bike" do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end

    it "raises error when empty" do
      expect{subject.release_bike}.to raise_error("No bikes left")
    end
  end

  describe "#dock" do
    it "docks something" do
      bike = Bike.new
      expect(subject.dock(bike)[0]).to eq bike
    end

    it "returns docked bikes" do
      bike = Bike.new
      expect(subject.dock(bike)[0]).to eq bike
    end

    it "raises an error when full" do
      20.times {subject.dock(Bike.new)}
      expect{subject.dock(Bike.new)}.to raise_error("No space left")
    end
  end

  describe "#working" do
    it "bike is working" do
      subject.dock(Bike.new)
      bike = subject.release_bike
      expect(bike).to be_working
    end
  end
end