class Printer
  def calc_winner(game)
    game.status == 2 ? 'Nobody' : game.players[game.status].name
  end

  def show_current(game)
    player, diller = game.players

    puts player
    puts diller.to_s_hide # TEST: puts diller
  end

  def show_total(game)
    player, diller = game.players
    winner = calc_winner(game)

    puts "The winner is #{winner}"
    puts player
    puts diller
  end
end
