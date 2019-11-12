require 'user'
require 'player'
require 'bank'

describe Bank do
  before(:context) do
    @player = Player.new('Dan').init
    @bank = Bank.new
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

  it 'error' do
    @player.balance = 0
    expect { @bank.deposit(@player) }
      .to raise_error('Game over for Dan, he is bankrot')
  end
end
