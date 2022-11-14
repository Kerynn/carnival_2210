require 'rspec'
require './lib/visitor'
require './lib/ride'

describe Ride do
  it 'exists' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

    expect(ride1).to be_a(Ride)
  end

  it 'has attributes of the ride' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

    expect(ride1.name).to eq('Carousel')
    expect(ride1.min_height).to eq(24)
    expect(ride1.admission_fee).to eq(1)
    expect(ride1.excitement).to eq(:gentle)
  end

  it 'starts with total revenue at 0' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

    expect(ride1.total_revenue).to eq(0)
  end

  it 'can board the rider' do
   ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
   visitor1 = Visitor.new('Bruce', 54, '$10')
   visitor2 = Visitor.new('Tucker', 36, '$5')
   visitor1.add_preferences(:gentle)
   visitor2.add_preferences(:gentle)

   ride1.board_rider(visitor1)
   ride1.board_rider(visitor2)
   ride1.board_rider(visitor1)

   expect(ride1.rider_log).to eq({
              visitor1 => 2,
              visitor2 => 1
            })
  end

  it 'decreases spending money after going on a ride' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')

    visitor1.add_preferences(:gentle)
    visitor2.add_preferences(:gentle)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)

    expect(visitor1.spending_money).to eq(8)
    expect(visitor2.spending_money).to eq(4)
  end

  it 'will calculate the total revenue of the ride' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')

    visitor1.add_preferences(:gentle)
    visitor2.add_preferences(:gentle)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)

    expect(ride1.total_revenue).to eq(3)
  end

  it 'will not board rider if preferences dont equal excitement or meet min height' do
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

    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)

    expect(ride3.rider_log).to eq({
                visitor3 => 1
      })
  end

  it 'only decrease the spending money of those that went on the ride' do
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

    expect(visitor1.spending_money).to eq(8)
    expect(visitor2.spending_money).to eq(4)
    expect(visitor3.spending_money).to eq(13)
  end

  it 'will calculate the total revenue of the ride' do
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

    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)

    expect(ride3.total_revenue).to eq(2)
  end
end
