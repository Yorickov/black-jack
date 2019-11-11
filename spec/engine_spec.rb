require 'card_deck'
require 'user'
require 'diller'
require 'engine'

describe Engine do
  before(:context) do
    @cards = CardDeck.new
    deck1 = []
    52.times { deck1 << ['6+', 6] }
    @cards.cards = deck1

    @diller1 = Diller.new('Sam')
    @diller2 = Diller.new('Sarah')
    @engine = Engine.new(@cards, @diller1, @diller2)
  end

  it 'creation' do
    expect(@engine.status).to eq(-1)
    expect(@engine.players.all? { |p| p.hand_sum == 12 }).to be_truthy
  end

  it 'process' do
    @engine.process
    @engine.process
    expect(@engine.status).to eq(2)
    expect(@engine.players.all? { |p| p.hand_sum == 18 }).to be_truthy
    expect(@engine.players.all? { |p| p.choice == 'added' }).to be_truthy
    expect(@engine.players.all? { |p| p.deposit == 100 }).to be_truthy

    @engine.init
    expect(@engine.status).to eq(-1)
    expect(@engine.players.all? { |p| p.choice == 'skip' }).to be_truthy
    expect(@engine.players.all? { |p| p.deposit == 90 }).to be_truthy
  end
end
