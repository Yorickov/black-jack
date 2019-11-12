require 'card_deck'
require 'user'
require 'diller'
require 'engine'
require 'printer'
require 'bank'

describe Engine do
  before(:context) do
    @cards = CardDeck.new
    deck1 = []
    52.times { deck1 << ['6+', 6] }
    @cards.cards = deck1

    @diller1 = Diller.new('Sam')
    @diller2 = Diller.new('Sarah')
    @bank = Bank.new
    @engine = Engine.new(@cards, @bank, @diller1, @diller2)
    @printer = Printer.new
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
    expect(@engine.players.all? { |p| p.balance == 100 }).to be_truthy
  end

  it 'print' do
    expected_curr = "Sam: 6+ | 18\nSarah: *\n"
    expect { @printer.show_current(@engine) }
      .to output(expected_curr).to_stdout

    expected_tot = "The winner is Nobody\nSam: 6+ | 18\nSarah: 6+ | 18\n"
    expect { @printer.show_total(@engine) }
      .to output(expected_tot).to_stdout
  end

  it 'new game' do
    @engine.init
    expect(@engine.status).to eq(-1)
    expect(@engine.players.all? { |p| p.choice == 'skip' }).to be_truthy
    expect(@engine.players.all? { |p| p.balance == 90 }).to be_truthy
  end
end
