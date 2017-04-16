# Makers Academy Week 1 Challenge: Boris Bikes

Learning to use a test-driven development approach to create object-oriented code.
This project emulates the basic infrastructure behind the London Santander bike scheme. Features include docking/releasing bikes from a docking station and determining whether a bike is working or broken. A `bike_container` module has been provided to DRY-up the code where both a `DockingStation` and `Garage` share common functionality.

### Technologies Used
- Ruby
- Rspec

## Installation
- Clone the repo

## Testing
- `cd` to the project folder
- Run `rspec`

## Running
- Run `irb`
- Run the following commands:

```
>> require './lib/bike.rb'
>> require './lib/docking_station.rb'
>> require './lib/van.rb'
>> require './lib/garage.rb'
>> require './lib/bike_container.rb'
>> bike1 = Bike.new
=> #<Bike:0x007fe4e517ffa8 @working=true>
>> bike2 = Bike.new
=> #<Bike:0x007fe4e517c858 @working=true>
>> bike3 = Bike.new
=> #<Bike:0x007fe4e519d0f8 @working=true>
>> ds = DockingStation.new
=> #<DockingStation:0x007fe4e51c5648 @bikes=[], @capacity=20>
>> ds.dock(bike1)
=> #<Bike:0x007fe4e517ffa8 @working=true>
>> ds.dock(bike2)
=> #<Bike:0x007fe4e517c858 @working=true>
>> ds.dock(bike3)
=> #<Bike:0x007fe4e519d0f8 @working=true>
>> ds.bikes
=> [#<Bike:0x007fe4e517ffa8 @working=true>, #<Bike:0x007fe4e517c858 @working=true>, #<Bike:0x007fe4e519d0f8 @working=true>]
>> ds.release_bike()
=> #<Bike:0x007fe4e517ffa8 @working=true>
>> ds.release_bike()
=> #<Bike:0x007fe4e517c858 @working=true>
>> ds.release_bike()
=> #<Bike:0x007fe4e519d0f8 @working=true>
>> ds.bikes
=> []
>> ds.release_bike()
RuntimeError: Sorry, the dock is empty.
	from /lib/docking_station.rb:10:in `release_bike'
	from (irb):18
	from /Users/.rvm/rubies/ruby-2.2.3/bin/irb:15:in `<main>'
```

### Behaviors Learnt
- [BDD](https://github.com/makersacademy/course/blob/master/pills/bdd_cycle.md)
- [Pair-Programing](https://github.com/makersacademy/course/blob/master/pills/pairing.md)

### Contributors
- Joe Maidman
- Ashwini Mani
- Katie Koschland
- Clem Capel-Bird
