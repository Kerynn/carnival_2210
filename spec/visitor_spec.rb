require 'rspec'
require './lib/visitor'
require './lib/ride'

describe Visitor do
  it 'exists' do
    visitor1 = Visitor.new('Bruce', 54, '$10')

    expect(visitor1).to be_a(Visitor)
  end

  it 'has a name, height, and spending money' do
    visitor1 = Visitor.new('Bruce', 54, '$10')

    expect(visitor1.name).to eq('Bruce')
    expect(visitor1.height).to eq(54)
    expect(visitor1.spending_money).to eq(10)
  end

  it 'has preferences that starts as an empty array' do
    visitor1 = Visitor.new('Bruce', 54, '$10')

    expect(visitor1.preferences).to eq([])
  end

  it 'can add preferences' do
    visitor1 = Visitor.new('Bruce', 54, '$10')

    visitor1.add_preferences(:gentle)
    visitor1.add_preferences(:water)

    expect(visitor1.preferences).to eq([:gentle, :water])
  end

  it 'can determine if visitor tall enough based on given threshold' do
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')

    expect(visitor1.tall_enough?(54)).to be true
    expect(visitor2.tall_enough?(54)).to be false
    expect(visitor3.tall_enough?(54)).to be true
    expect(visitor1.tall_enough?(64)).to be false
  end

  it 'will decrease spending money when paid for ride' do
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor1.paid(1)

    expect(visitor1.spending_money).to eq(9)

    visitor1.paid(5)

    expect(visitor1.spending_money).to eq(4)
  end
end
