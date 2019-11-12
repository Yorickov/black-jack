require 'user'
require 'validation'
require 'player'

describe Player do
  it 'player choices' do
    player = Player.new('Sam').init
    expect(player.choice).to eq('skip')
  end

  it 'presence' do
    player = Player.new('John')
    expect(player.valid?).to be_truthy

    expect { Player.new('   ') }
      .to raise_error(ArgumentError, 'You must input smth.')
  end
end
