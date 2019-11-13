class Game
  BET = 10
  INITIAL_PLAYER_BALANCE = 100

  attr_reader :player

  def initialize
    @player = create_player
    @engine = create_engine
  end

  def controller
    Interface.welcome_message

    flow
    Interface.show_total(engine)

    choice = Interface.ask_one_more?
    return Interface.goodbye_message(engine) unless choice
    return Interface.game_over_message(engine.bankrut.name) if engine.bankrupt

    Interface.new_round

    engine.init
    controller
  end

  private

  attr_reader :engine

  def create_player
    name = Interface.ask_player_name

    Player.new(INITIAL_PLAYER_BALANCE, name)
  rescue ArgumentError => e
    Interface.error_message(e)
    retry
  end

  def create_engine
    cards = CardDeck.new
    diller = Diller.new(INITIAL_PLAYER_BALANCE)
    bank = Bank.new(BET)
    Engine.new(cards, bank, player, diller)
  end

  def flow
    return unless engine.status == -1

    Interface.show_current(engine)
    decision = Interface.ask_player_decision(engine)
    engine.next_turn(decision)
    flow
  end
end
