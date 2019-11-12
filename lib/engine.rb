class Engine
  attr_reader :cards, :players, :status, :bank

  MAX_SUM = 21

  def initialize(cards, bank, player, diller)
    @players = [player, diller]
    @cards = cards
    @bank = bank
    init
  end

  def init
    cards.prepare_deck
    @status = -1 # 0 player win, 1 - diller win, 2 - nobody
    @curr_player_index = 0

    players.each do |p|
      p.init
      bank.deposit(p)
      p.update_hand(*cards.give_two)
    end
  end

  def process
    next_turn if status == -1
  end

  private

  attr_reader :curr_player_index

  def next_turn
    curr_player = players[curr_player_index]
    curr_player.make_turn
    @curr_player_index = curr_player_index.zero? ? 1 : 0

    case curr_player.choice
    when 'open'
      calc_result
    when 'added'
      curr_player.update_hand(cards.give_one)
      calc_result if players.all?(&:full?)
    end
  end

  def calc_result
    player, diller = players
    player_check = MAX_SUM - player.hand_sum
    diller_check = MAX_SUM - diller.hand_sum

    calc_status(player_check, diller_check)
    calc_deposit
  end

  def calc_status(player_check, diller_check)
    @status =
      if player_check.negative?
        1
      elsif diller_check.negative? || player_check < diller_check
        0
      elsif player_check > diller_check
        1
      else
        2
      end
  end

  # TODO: Bank?
  def calc_deposit
    if status == 2
      players.each { |p| bank.withdraw(p) }
    else
      bank.take_all(players[status])
    end
  end
end
