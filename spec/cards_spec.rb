require 'cards'

describe Cards do
  before(:context) do
    @cards = Cards.new
  end

  it 'creation' do
    expect(@cards.cards.first).to eq(['2^', 2])

    @cards.prepare_deck
    expect(@cards.deck).not_to eq(@cards.cards)
  end

  it 'manipulaion' do
    expect(@cards.deck.size).to eq(52)

    @cards.give_two
    @cards.give_one
    expect(@cards.deck.size).to eq(49)
  end

  it 'new game' do
    @cards.prepare_deck
    expect(@cards.deck.size).to eq(52)
  end
end
