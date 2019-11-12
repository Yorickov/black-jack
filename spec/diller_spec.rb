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
  end

  it 'print' do
    expect(@diller.to_s).to eq('Dan: 3+ Ace+ | 14 | balance: 100')
    expect(@diller.to_s_hide).to eq('Dan: * *')
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
    expect(@diller.balance).to eq(100)
  end
end
