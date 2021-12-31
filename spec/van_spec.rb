require "van"

describe Van do
  let (:workingbikeone) {double :bike1, working?: true}
  let (:workingbiketwo) {double :bike2, working?: true}
  let (:workingbikethree) {double :bike3, working?: true}
  let (:workingbikefour) {double :bike4, working?: true}
  let (:brokenbikeone) {double :bike5, working?: false}
  let (:brokenbiketwo) {double :bike6, working?: false}
  let (:brokenbikethree) {double :bike7, working?: false}

  let (:fullbikes) {double :fullbikes, bikes: [workingbikeone, brokenbikeone, workingbiketwo, brokenbiketwo, workingbikethree, workingbikefour, brokenbikethree]}
  let (:emptybikes) {double :emptybikes, bikes: []}


  describe "#collect_broken" do
    it { is_expected.to respond_to(:collect_broken).with(1).argument }

    it "only collects broken bikes" do
      allow(fullbikes).to receive(:broken_bikes).and_return([brokenbikeone, brokenbiketwo, brokenbikethree])

      subject.collect_broken(fullbikes)
      expect(subject.bikes).to eq [brokenbikeone, brokenbiketwo, brokenbikethree]
    end

    it "leaves behind working bikes" do
      allow(fullbikes).to receive(:broken_bikes).and_return([brokenbikeone, brokenbiketwo, brokenbikethree])

      subject.collect_broken(fullbikes)
      expect(fullbikes.bikes).to eq [workingbikeone, workingbiketwo, workingbikethree, workingbikefour]
    end
  end

  describe "#drop_off" do
    it {is_expected.to respond_to(:drop_off).with(1).argument}

    it "removes broken bikes from van" do
      subject.bikes.push(workingbikeone, brokenbikeone, workingbiketwo, brokenbiketwo, workingbikethree, workingbikefour, brokenbikethree)

      subject.drop_off(emptybikes)
      expect(subject.bikes).to eq [workingbikeone, workingbiketwo, workingbikethree, workingbikefour]
    end

    it "deposits broken bikes in bikes" do
      subject.bikes.push(workingbikeone, brokenbikeone, workingbiketwo, brokenbiketwo, workingbikethree, workingbikefour, brokenbikethree)

      subject.drop_off(emptybikes)
      expect(emptybikes.bikes).to eq [brokenbikeone, brokenbiketwo, brokenbikethree]
    end
  end

  describe "#collect_working" do
    it {is_expected.to respond_to(:collect_working).with(1).argument}

    it "removes working bikes from the garage" do
      allow(fullbikes).to receive(:working_bikes).and_return([workingbikeone, workingbiketwo, workingbikethree, workingbikefour])

      subject.collect_working(fullbikes)
      expect(subject.bikes).to eq [workingbikeone, workingbiketwo, workingbikethree, workingbikefour]
    end

    it "leaves broken bikes in the garage" do
      allow(fullbikes).to receive(:working_bikes).and_return([workingbikeone, workingbiketwo, workingbikethree, workingbikefour])

      subject.collect_working(fullbikes)
      expect(fullbikes.bikes).to eq [brokenbikeone, brokenbiketwo, brokenbikethree]
    end
  end

end
