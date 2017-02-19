require "docking_station"
require "bike"
require "garage"
require 'support/shared_examples_for_bike_container'

describe Van do
  it_behaves_like BikeContainer

  describe '#dock' do
    it { is_expected.to respond_to(:dock) }

    it "raises an error if the van is full" do
      subject.capacity.times {subject.dock Bike.new(false)}
      expect { subject.dock Bike.new(false)}.to raise_error("Sorry, the van is full.")
    end
  end

  describe "#release" do
    it { is_expected.to respond_to(:release_bike) }

    it "raises an error if the van is empty" do
      expect { subject.release_bike}.to raise_error("Sorry, the van is empty!")
    end
  end

  describe '#take' do
    it { is_expected.to respond_to(:take) }

    it "does nothing with an empty docking station" do
      ds = DockingStation.new
      van = Van.new
      expect{van.take(ds)}.to raise_error("Docking station is empty.")
    end

    it "fills the van to capacity with broken bikes when passed a docking station" do
      ds = DockingStation.new(5)
      5.times{ds.dock(Bike.new(false))}
      van = Van.new(2)
      van.take(ds)
      expect(van.bikes.length).to eq  2
    end
  end

  describe '#collect' do
    it { is_expected.to respond_to(:collect) }

    it "does nothing with an empty garage" do
      expect{subject.collect(Garage.new)}.to raise_error("Garage has no bikes.")
    end

    it "fills the van to capacity with working bikes when passed a garage" do
      garage = Garage.new(5)
      5.times{garage.dock(Bike.new(false))}
      van = Van.new(2)
      van.collect(garage)
      expect(van.bikes.length).to eq  2
    end
  end

  describe '#deliver' do
    it { is_expected.to respond_to(:deliver) }

    it "raises an error if the van is empty" do
      expect {subject.deliver(Garage.new)}.to raise_error("Van has no bikes.")
    end

    it "raises an error if the van has no broken bikes" do
      van = Van.new
      van.dock(Bike.new)
      expect {van.deliver(Garage.new)}.to raise_error("Van has no broken bikes.")
    end

    it "delivers all broken bikes on the van to a garage " do
      van = Van.new
      van.dock(Bike.new)
      van.dock(Bike.new(false))
      van.dock(Bike.new(false))
      van.deliver(Garage.new)
      expect(van.bikes.length).to eq 1
    end
  end

  describe '#distribute' do
    it { is_expected.to respond_to(:distribute) }

    it "raises an error if the van is empty" do
      expect {subject.distribute(DockingStation.new)}.to raise_error("Van has no bikes.")
    end

    it "raises an error if the van has no working bikes" do
      van = Van.new
      van.dock(Bike.new(false))
      expect {van.distribute(DockingStation.new)}.to raise_error("Van has no working bikes.")
    end

    it "distributes all working bikes on the van to a docking station" do
      van = Van.new
      van.dock(Bike.new)
      van.dock(Bike.new(false))
      van.dock(Bike.new(false))
      van.distribute(DockingStation.new)
      expect(van.bikes.length).to eq 2
    end
  end

end
