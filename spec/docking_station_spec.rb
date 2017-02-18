require "docking_station"

describe DockingStation do

  describe "#initialize the docking station" do
    it "should have a default capacity of 20 if no other capacity is set" do
      expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
    end
  end

  describe "#bikes" do
    it { is_expected.to respond_to(:bikes) }

    it "return an array of docked bikes" do
      array_of_bikes = []
      DockingStation::DEFAULT_CAPACITY.times {array_of_bikes.push(subject.dock Bike.new)}
      expect(subject.bikes).to eq array_of_bikes
      end
    end

  describe "#release_bike" do
    it { is_expected.to respond_to(:release_bike) }

    it "only releases a bike when there is a working bikes available" do
      bike = Bike.new(true)
      subject.dock(bike)
      expect(subject.release_bike). to eq bike
    end

    it "does not release a bike when there are no working bikes available" do
        bike = Bike.new(false)
        subject.dock(bike)
        expect{ subject.release_bike }.to raise_error("Sorry, no working bikes available.")
    end

    it "check the dock dosen't return a broken bike when there is a broken and a working bike in the dock" do
      bike = Bike.new()
      bike_broken = Bike.new(false)
      subject.dock(bike)
      subject.dock(bike_broken)
      subject.release_bike
      expect { subject.release_bike }.to raise_error("Sorry, no working bikes available.")
    end

    it "raises error when there are no bikes to release" do
      expect { subject.release_bike }.to raise_error("Sorry, the dock is empty.")
    end
  end

  describe '#dock' do
    it { is_expected.to respond_to(:dock).with(1).argument }

    it "raises an error when the dock is full" do
      subject.capacity.times {subject.dock Bike.new}
      expect { subject.dock Bike.new }.to raise_error("Sorry, the dock is full.")
    end

    it "docks a bike and tells us which bike was docked" do
      bike = Bike.new
      expect(subject.dock(bike)).to eq bike
    end

    it "has a variable capacity" do
      docking_station = DockingStation.new(50)
      50.times {docking_station.dock Bike.new}
      expect { docking_station.dock Bike.new}.to raise_error("Sorry, the dock is full.")
      end
    end

end
