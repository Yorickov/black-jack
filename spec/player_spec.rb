require 'user'
require 'validation'
require 'player'

describe Player do
  it 'player choices' do
    player = Player.new('Sam').init
    expect(player.choice).to eq('skip')
  end
end
