class Diller < User
  def make_turn
    if hand_sum >= 17 || full?
      skip_turn
    else
      add_card
    end
  end

  def to_s_hide
    "#{name}: #{cards_to_s_hide}"
  end

  private

  def cards_to_s_hide
    hand.to_h.keys.map { '*' }.join(' ')
  end
end
