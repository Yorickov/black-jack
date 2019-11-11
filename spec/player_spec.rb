require 'user'
require 'player'

describe Player do
  it 'player choices' do
    player = Player.new('Sam')
    player.open_cards
    expect(player.choice).to eq('open')
  end
end
