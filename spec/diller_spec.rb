require 'user'
require 'diller'

describe Diller do
  before(:context) do
    @diller = Diller.new('Dan').init
  end

  it 'creation' do
    expect(@diller.name).to eq('Dan')
    expect(Diller.new.name).to eq('Diller')
    expect(@diller.choice).to eq('skip')
  end

  it 'update hand' do
    @diller.update_hand(['3+', 3], ['Ace+', [1, 11]])
    expect(@diller.hand_sum).to eq(14)
    expect(@diller.deposit).to eq(90)
  end

  it 'state' do
    @diller.make_turn
    expect(@diller.choice).to eq('added')

    @diller.update_hand(['Ace<>', [1, 11]])
    expect(@diller.hand_sum).to eq(15)

    expect(@diller.full?).to be_truthy

    @diller.make_turn
    expect(@diller.choice).to eq('skip')
  end

  it 'new game' do
    @diller.init
    expect(@diller.hand_sum).to eq(0)
    expect(@diller.deposit).to eq(100)
  end
end
