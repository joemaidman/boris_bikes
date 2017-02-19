require 'bike_container'
require 'support/shared_examples_for_bike_container'
require 'van'
shared_examples_for BikeContainer do

  describe "#initialize the container" do  #,  :focus => true
    it "should have a default capacity of 20 if no other capacity is set" do
      expect(subject.capacity).to eq BikeContainer::DEFAULT_CAPACITY
    end
  end


end
