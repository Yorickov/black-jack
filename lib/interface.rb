module Interface
  module_function

  def ask_player_name
    puts 'Input your name'

    gets.chomp.strip
  end

  def show_current(engine)
    player, diller = engine.players
    puts player
    puts diller.to_s_hide
  end

  def show_total(engine)
    player, diller = engine.players
    winner = engine.status == 2 ? 'Nobody' : engine.players[engine.status].name

    puts "The winner is #{winner}"
    puts player
    puts diller
  end

  def welcome_message
    puts 'Hello, lets start the game!'
  end

  def error_message(err)
    puts err.message
  end

  def ask_one_more?
    puts 'Input Y to play again or any key to exit'
    gets.chomp.strip.downcase == 'y'
  end

  def goodbye_message(engine)
    player, diller = engine.players
    puts "Buy, #{player.name}!\nYour balance: " \
      "#{player.balance}, your opponent balance: #{diller.balance}"
  end

  def ask_player_decision(engine)
    curr_player = engine.players[engine.curr_player_index]
    return if curr_player.class == Diller

    puts 'input M to miss turn, A to add card or O to open cards'

    choice = ''
    until %w[m a o].include?(choice)
      choice = gets.chomp.strip.downcase
      if choice == 'a' && curr_player.full?
        puts 'You can not add any card'
        choice = ''
      end
    end

    choice
  end

  def game_over_message(name)
    puts "Game over for #{name}, he is bankrupt"
  end
end
