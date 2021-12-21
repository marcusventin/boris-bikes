require "bike"
describe Bike do

  describe "#initialize" do
    it "sets working_status to true" do
      bike = Bike.new
      expect(bike.working_status).to eq true
    end
  end

  describe "#working" do
    it "responds to working" do
      expect(subject).to respond_to :working?
    end
  end

  describe "#report" do
    it { is_expected.to respond_to :report }
    
    it "turns working_status to false" do
      bike = Bike.new
      bike.report
      expect(bike.working_status).to eq false
    end
  end
end