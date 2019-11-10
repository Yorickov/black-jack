require 'user'
require 'player'

describe Player do
  it 'test' do
    player = Player.new('Sam')
    expect(player.name).to eq('Sam')
  end
end
