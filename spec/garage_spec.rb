require "docking_station"
require "bike"
require "van"
require 'support/shared_examples_for_bike_container'

describe Garage do
  it_behaves_like BikeContainer

  bike = Bike.new
  broken_bike = Bike.new(false)

  describe '#dock' do
    it { is_expected.to respond_to(:dock) }

    it "raises an error if the bike being docked is working" do
      expect{subject.dock(bike)}.to raise_error("I only accept broken bikes!")
    end

    it "raises an error if the garage is full" do
      subject.capacity.times {subject.dock Bike.new(false)}
      expect { subject.dock Bike.new(false)}.to raise_error("Sorry, the garage is full.")
    end

    it "fixes a broken bike when it is docked" do
      a_fixed_bike = subject.dock(broken_bike)
      expect(a_fixed_bike).to be_working
    end
  end

  describe "#release" do
    it { is_expected.to respond_to(:release_bike) }

    it "raises an error if the garage is empty" do
      expect { subject.release_bike}.to raise_error("Sorry, the garage is empty!")
    end
  end

end
