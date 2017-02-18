require "docking_station"

describe DockingStation do
  let(:bike) { double :bike}
  let(:broken_bike) { double :bike}

  # The is the shorthand syntax to define stubs for the double without having to allow and return style
  # let(:bike) { double :bike, working?: true}
  # let(:broken_bike) { double :bike, working?: false}


  describe "#initialize the docking station" do
    it "should have a default capacity of 20 if no other capacity is set" do
      expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
    end
  end

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
    it { is_expected.to respond_to(:dock).with(1).argument }

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

end
