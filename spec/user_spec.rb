require 'user'

describe User do
  before(:context) do
    @user = User.new('Dan')
  end

  it 'creation' do
    expect(@user.name).to eq('Dan')
    expect(User.new.name).to eq('Diller')
  end

  it 'update hand' do
    @user.update_hand(['3+', 3], ['Ace+', [1, 11]])
    expect(@user.hand_sum).to eq(14)
    expect(@user.deposit).to eq(90)

    @user.update_hand(['Ace+', [1, 11]])
    expect(@user.hand_sum).to eq(15)
  end

  it 'new game' do
    @user.init
    expect(@user.hand_sum).to eq(0)
    expect(@user.deposit).to eq(100)
  end
end
