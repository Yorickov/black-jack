class Game
  attr_reader :player

  def initialize
    @player = create_player
    @engine = create_engine
    @printer = Printer.new
  end

  def start
    flow
    printer.show_total(engine)

    puts "#{player.name}, nput Y to play again or any key to exit"

    choice = gets.chomp.strip.downcase
    return unless choice == 'y'

    begin
      engine.init
    rescue => e
      puts e.message
      return
    end
    start
  end

  private

  attr_reader :engine, :printer

  def create_player
    puts 'Input your name'

    name = gets.chomp.strip
    Player.new(name)
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def create_engine
    cards = CardDeck.new
    diller = Diller.new
    bank = Bank.new
    Engine.new(cards, bank, player, diller)
  end

  def flow
    return unless engine.status == -1

    printer.show_current(engine)
    engine.process
    flow
  end
end
