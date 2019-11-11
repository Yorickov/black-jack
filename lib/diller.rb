class Diller < User
  def make_turn
    if hand_sum >= 17 || full?
      skip_turn
    else
      add_card
    end
  end


end
