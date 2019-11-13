require 'card_deck'
require 'user'
require 'diller'
require 'engine'
require 'bank'
require 'interface'

describe Engine do
  before(:context) do
    @cards = CardDeck.new
    deck1 = []
    52.times { deck1 << ['6+', 6] }
    @cards.cards = deck1

    @diller1 = Diller.new(100, 'Sam')
    @diller2 = Diller.new(100, 'Sarah')
    @bank = Bank.new(10)
    @engine = Engine.new(@cards, @bank, @diller1, @diller2)
  end

  it 'creation' do
    expect(@engine.status).to eq(-1)
    expect(@engine.players.all? { |p| p.hand_sum == 12 }).to be_truthy
  end

  it 'process' do
    @engine.next_turn(nil)
    @engine.next_turn(nil)
    expect(@engine.status).to eq(2)
    expect(@engine.players.all? { |p| p.hand_sum == 18 }).to be_truthy
    expect(@engine.players.all? { |p| p.choice == 'added' }).to be_truthy
    expect(@engine.players.all? { |p| p.balance == 100 }).to be_truthy
  end

  it 'print' do
    expected_curr = "Sam: 6+ | 18 | balance: 100\nSarah: *\n"
    expect { Interface.show_current(@engine) }
      .to output(expected_curr).to_stdout

    expected_tot = "The winner is Nobody\nSam: 6+ | 18 | balance: 100\n" \
      "Sarah: 6+ | 18 | balance: 100\n"
    expect { Interface.show_total(@engine) }
      .to output(expected_tot).to_stdout
  end

  it 'new game' do
    @engine.init
    expect(@engine.status).to eq(-1)
    expect(@engine.players.all? { |p| p.choice == 'skip' }).to be_truthy
    expect(@engine.players.all? { |p| p.balance == 90 }).to be_truthy
  end
end
