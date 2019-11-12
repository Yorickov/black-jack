class Game
  attr_reader :name

  def initialize
    @name = create_name
    @engine = create_engine(@name)
    @printer = Printer.new
    @bank = Bank.new
  end

  def start
    flow
    printer.show_total(engine)

    puts "#{name}, nput Y to play again or any key to exit"

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

  def create_name
    puts 'Input your name'

    name = gets.chomp.strip
    create_name if name == ''
    name
  end

  def create_engine(name)
    cards = CardDeck.new
    diller = Diller.new
    player = Player.new(name)
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
