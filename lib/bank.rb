class Bank
  attr_accessor :desk

  def initialize
    @desk = 0
  end

  def deposit(player)
    raise "Sorry, #{player.name}, you are bankrot" if player.balance < 10

    player.balance -= 10
    @desk += 10
  end

  def withdraw(player)
    player.balance += 10
    @desk -= 10
  end

  def take_all(player)
    player.balance += desk
    @desk = 0
  end
end
