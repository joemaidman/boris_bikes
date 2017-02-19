require "docking_station"
require "garage"
require 'support/shared_examples_for_bike_container'

describe DockingStation do
  it_behaves_like BikeContainer
  let(:bike) { double :bike, working?: true}
  let(:broken_bike) { double :bike, working?: false}
  garage = Garage.new
  # The is the shorthand syntax to define stubs for the double without having to allow and return style
  # let(:bike) { double :bike, working?: true}
  # let(:broken_bike) { double :bike, working?: false}

  describe "#bikes" do
    it { is_expected.to respond_to(:bikes) }

    it "return an array of docked bikes" do
      array_of_bikes = []
      DockingStation::DEFAULT_CAPACITY.times {array_of_bikes.push(subject.dock bike)}
      expect(subject.bikes).to eq array_of_bikes
      end
    end

  describe "#release_bike" do
    it { is_expected.to respond_to(:release_bike) }

    it "only releases a bike when there is a working bike available" do
      allow(bike).to receive(:working?).and_return(true)
      subject.dock(bike)
      expect(subject.release_bike). to eq bike
    end

    it "does not release a bike when there are no working bikes in the docking station" do
        allow(broken_bike).to receive(:working?).and_return(false)
        subject.dock(broken_bike)
        expect{ subject.release_bike }.to raise_error("Sorry, no working bikes available.")
    end

    it "the dock dosen't return a broken bike when there is a broken and a working bike in the docking station" do
      allow(bike).to receive(:working?).and_return(true)
      allow(broken_bike).to receive(:working?).and_return(false)
      subject.dock(bike)
      subject.dock(broken_bike)
      subject.release_bike
      expect { subject.release_bike }.to raise_error("Sorry, no working bikes available.")
    end

    it "raises error when there are no bikes to release" do
      expect { subject.release_bike }.to raise_error("Sorry, the dock is empty.")
    end
  end

  describe '#dock' do
    it { is_expected.to respond_to(:dock) }

    it "raises an error when the dock is full" do
      subject.capacity.times {subject.dock bike}
      expect { subject.dock bike}.to raise_error("Sorry, the dock is full.")
    end

    it "docks a bike and tells us which bike was docked" do
      expect(subject.dock(bike)).to eq bike
    end

    it "has a variable capacity" do
      docking_station = DockingStation.new(50)
      50.times {docking_station.dock bike}
      expect { docking_station.dock bike}.to raise_error("Sorry, the dock is full.")
      end
    end

    describe "#release_broken_bike" do
      it { is_expected.to respond_to(:release_broken_bike)}
      it "releases a broken bike" do
        subject.dock(broken_bike)
        expect(subject.release_broken_bike).to eq broken_bike
      end

      it "raises an error if there are no bikes in the docking station" do
        expect{ subject.release_broken_bike }.to raise_error("Sorry, the dock is empty.")
      end

      it "raises an error if there are no broken bikes in the docking station" do
        subject.dock(bike)
        expect{ subject.release_broken_bike }.to raise_error("Good news, no broken bikes available!")
      end
    end

end
