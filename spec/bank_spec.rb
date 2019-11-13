require 'user'
require 'validation'
require 'player'
require 'bank'

describe Bank do
  before(:context) do
    @player = Player.new(100, 'Dan').init
    @bank = Bank.new(10)
  end

  it 'deposit' do
    @bank.deposit(@player)
    expect(@bank.desk).to eq(10)
    expect(@player.balance).to eq(90)
  end

  it 'withdraw' do
    @bank.withdraw(@player)
    expect(@bank.desk).to eq(0)
    expect(@player.balance).to eq(100)
  end

  it 'take_all' do
    @bank.desk = 30
    @bank.take_all(@player)
    expect(@bank.desk).to eq(0)
    expect(@player.balance).to eq(130)
  end
end
