require 'cards'
require 'user'
require 'diller'
require 'engine'

describe Engine do
  before(:context) do
    @cards = Cards.new
    deck1 = []
    52.times { deck1 << ['6+', 6] }
    @cards.cards = deck1
    @diller1 = Diller.new('Sam')
    @diller2 = Diller.new('Sarah')
    @engine = Engine.new(@cards, @diller1, @diller2)
  end

  it 'creation' do
    expect(@engine.status).to eq(-1)
    expect(@engine.players[0].hand_sum).to eq(12)
    expect(@engine.players[1].hand_sum).to eq(12)
  end

  it 'process' do
    @engine.process
    @engine.process
    expect(@engine.status).to eq(2)
    expect(@engine.players[0].hand_sum).to eq(18)
    expect(@engine.players[1].hand_sum).to eq(18)
    expect(@engine.players[0].choice).to eq('added')
    expect(@engine.players[1].choice).to eq('added')

    @engine.init
    expect(@engine.status).to eq(-1)
    expect(@engine.players[0].choice).to eq('skip')
  end
end
