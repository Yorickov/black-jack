class User
  attr_reader :name, :hand_sum, :deposit

  MAX_SUM = 21
  INIT_DEPOSIT = 100

  def initialize(name = 'Diller')
    @name = name
    init
  end

  def update_hand(*cards)
    @deposit -= 10 if cards.size > 1

    hand.push(*cards)
    calc_hand
  end

  def init
    @hand = []
    @hand_sum = 0
    @deposit = INIT_DEPOSIT
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
end
