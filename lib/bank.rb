class Bank
  attr_accessor :desk, :bet

  def initialize(bet)
    @desk = 0
    @bet = bet
  end

  def deposit(player)
    player.balance -= bet
    @desk += bet
  end

  def withdraw(player)
    player.balance += bet
    @desk -= bet
  end

  def take_all(player)
    player.balance += desk
    @desk = 0
  end
end
