require 'rspec'
require './lib/ride'
require './lib/visitor'
require './lib/carnival'

describe Carnival do
  it 'exists' do
    carnival = Carnival.new('2 weeks')

    expect(carnival).to be_a(Carnival)
  end

  it 'has a duration' do
    carnival = Carnival.new('2 weeks')

    expect(carnival.duration).to eq('2 weeks')
  end

  it 'starts out with an empty array of rides' do
    carnival = Carnival.new('2 weeks')

    expect(carnival.rides).to eq([])
  end

  it 'can add rides to the carnival' do
    carnival = Carnival.new('2 weeks')
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })

    carnival.add_ride(ride1)
    carnival.add_ride(ride2)

    expect(carnival.rides).to eq([ride1, ride2])
  end

  it 'can determine the most popular ride' do
    carnival = Carnival.new('2 weeks')
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

    visitor1.add_preferences(:gentle)
    visitor2.add_preferences(:gentle)
    visitor2.add_preferences(:thrilling)
    visitor3.add_preferences(:thrilling)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)

    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    expect(carnival.most_popular_ride).to eq(ride1)
  end
end
