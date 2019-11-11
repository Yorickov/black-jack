class Player < User
  def make_turn
    puts 'input M to miss turn, A to add card or O to open cards'

    choice = gets.chomp.strip.downcase
    case choice
    when 'm'
      skip_turn
    when 'a'
      if full?
        puts 'You can not add any card'
        make_turn
      else
        add_card
      end
    when 'o'
      open_cards
    else make_turn
    end
  end

  private

  def open_cards
    @choice = 'open'
  end
end
