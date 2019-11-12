class User
  attr_accessor :balance
  attr_reader :name, :hand_sum, :choice

  MAX_SUM = 21
  INIT_BALANCE = 100 # TEST: 20

  def initialize(name = 'Diller')
    @name = name
    @balance = INIT_BALANCE
  end

  def update_hand(*cards)
    hand.push(*cards)
    calc_hand
  end

  def init
    @hand = []
    @hand_sum = 0
    @choice = 'skip'
    self
  end

  def full?
    hand.size == 3
  end

  def to_s
    "#{name}: #{cards_to_s} | #{hand_sum} | balance: #{balance}"
  end

  protected

  attr_reader :hand

  def calc_hand
    ace_content, rest = hand.partition { |k, _v| k.include?('Ace') }
    result = rest.map { |_k, v| v }.sum

    unless ace_content.size.positive?
      @hand_sum = result
      return result
    end

    while ace_content.size.positive?
      _key, value = ace_content.pop
      value1, value11 = value

      added = (value11 + result) < MAX_SUM ? value11 : value1
      result += added
    end
    @hand_sum = result
  end

  def skip_turn
    @choice = 'skip'
  end

  def add_card
    @choice = 'added'
  end

  def cards_to_s
    hand.to_h.keys.join(' ')
  end
end
