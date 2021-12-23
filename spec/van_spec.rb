require "van"

describe Van do
  
  describe "#collect_broken" do

    it { is_expected.to respond_to(:collect_broken).with(1).argument }

    it "only collects broken bikes" do
      workingbikeone = double(:bike1, working?: true)
      workingbiketwo = double(:bike2, working?: true)
      workingbikethree = double(:bike3, working?: true)
      workingbikefour = double(:bike4, working?: true)
      brokenbikeone = double(:bike5, working?: false)
      brokenbiketwo = double(:bike6, working?: false)
      brokenbikethree = double(:bike7, working?: false)

      dockingstation = double(:dockingstation, bikes: [workingbikeone, brokenbikeone, workingbiketwo, brokenbiketwo, workingbikethree, workingbikefour, brokenbikethree])

      subject.collect_broken(dockingstation)
      expect( subject.van ).to eq [brokenbikeone, brokenbiketwo, brokenbikethree]
    end

    it "leaves behind working bikes" do
      workingbikeone = double(:bike1, working?: true)
      workingbiketwo = double(:bike2, working?: true)
      workingbikethree = double(:bike3, working?: true)
      workingbikefour = double(:bike4, working?: true)
      brokenbikeone = double(:bike5, working?: false)
      brokenbiketwo = double(:bike6, working?: false)
      brokenbikethree = double(:bike7, working?: false)

      dockingstation = double(:dockingstation, bikes: [workingbikeone, brokenbikeone, workingbiketwo, brokenbiketwo, workingbikethree, workingbikefour, brokenbikethree] )

      subject.collect_broken(dockingstation)
      expect(dockingstation.bikes).to eq [workingbikeone, workingbiketwo, workingbikethree, workingbikefour]
    end

  end

  describe "#drop_off" do

    it {is_expected.to respond_to(:drop_off).with(1).argument}

    it "removes broken bikes from van" do
      workingbikeone = double(:bike1, working?: true)
      workingbiketwo = double(:bike2, working?: true)
      workingbikethree = double(:bike3, working?: true)
      workingbikefour = double(:bike4, working?: true)
      brokenbikeone = double(:bike5, working?: false)
      brokenbiketwo = double(:bike6, working?: false)
      brokenbikethree = double(:bike7, working?: false)
  
      garage = double(:garage, workshop: [])

      subject.van.push(workingbikeone, brokenbikeone, workingbiketwo, brokenbiketwo, workingbikethree, workingbikefour, brokenbikethree)

      subject.drop_off(garage)
      expect(subject.van).to eq [workingbikeone, workingbiketwo, workingbikethree, workingbikefour]
    end

    it "deposits broken bikes in workshop" do
      workingbikeone = double(:bike1, working?: true)
      workingbiketwo = double(:bike2, working?: true)
      workingbikethree = double(:bike3, working?: true)
      workingbikefour = double(:bike4, working?: true)
      brokenbikeone = double(:bike5, working?: false)
      brokenbiketwo = double(:bike6, working?: false)
      brokenbikethree = double(:bike7, working?: false)

      garage = double(:garage, workshop: [])

      subject.van.push(workingbikeone, brokenbikeone, workingbiketwo, brokenbiketwo, workingbikethree, workingbikefour, brokenbikethree)
      subject.drop_off(garage)
      expect(garage.workshop).to eq [brokenbikeone, brokenbiketwo, brokenbikethree]
    end
  end

  describe "#collect_working" do

    it {is_expected.to respond_to(:collect_working).with(1).argument}

    it "removes working bikes from the garage" do
      workingbikeone = double(:bike1, working?: true)
      workingbiketwo = double(:bike2, working?: true)
      workingbikethree = double(:bike3, working?: true)
      workingbikefour = double(:bike4, working?: true)
      brokenbikeone = double(:bike5, working?: false)
      brokenbiketwo = double(:bike6, working?: false)
      brokenbikethree = double(:bike7, working?: false)

      garage = double(:garage, workshop: [workingbikeone, brokenbikeone, workingbiketwo, brokenbiketwo, workingbikethree, workingbikefour, brokenbikethree] )

      subject.collect_working(garage)
      expect(subject.van).to eq [workingbikeone, workingbiketwo, workingbikethree, workingbikefour]
    end

    it "leaves broken bikes in the garage" do
      workingbikeone = double(:bike1, working?: true)
      workingbiketwo = double(:bike2, working?: true)
      workingbikethree = double(:bike3, working?: true)
      workingbikefour = double(:bike4, working?: true)
      brokenbikeone = double(:bike5, working?: false)
      brokenbiketwo = double(:bike6, working?: false)
      brokenbikethree = double(:bike7, working?: false)

      garage = double(:garage, workshop: [workingbikeone, brokenbikeone, workingbiketwo, brokenbiketwo, workingbikethree, workingbikefour, brokenbikethree] )

      subject.collect_working(garage)
      expect(garage.workshop).to eq [brokenbikeone, brokenbiketwo, brokenbikethree]
    end
  end

end
