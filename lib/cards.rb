class Cards
  attr_reader :cards, :deck

  def initialize
    @cards = create_cards
  end

  def prepare_deck
    @deck = cards.shuffle
  end

  def give_two
    deck.pop(2)
  end

  def give_one
    deck.pop
  end

  private

  def create_cards
    base = [*2..10, 'Jack', 'Queen', 'King', 'Ace'].map do |c|
      value =
        if c == 'Ace'
          [1, 11]
        elsif c.is_a?(String)
          10
        else
          c
        end
      [c, value]
    end

    ['^', '+', '<>', '<3'].reduce([]) do |acc, item|
      suit = base.map { |k, v| ["#{k}#{item}", v] }
      [*acc, *suit]
    end
  end
end
