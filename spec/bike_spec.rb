require "bike"
describe Bike do

  describe "#initialize" do
    it "sets working_status to true" do
      expect(subject.working_status).to eq true
    end
  end

  describe "#working" do
    it { is_expected.to respond_to(:working?) }

    it "returns working_status" do
      expect( subject.working? ).to eq subject.working_status
    end
  end

  describe "#report" do
    it { is_expected.to respond_to :report }
    
    it "turns working_status to false" do
      subject.report
      expect(subject.working_status).to eq false
    end
  end

end