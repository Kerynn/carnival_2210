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
end
