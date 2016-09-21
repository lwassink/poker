class Player
  attr_reader :pot, :hand

  def initialize(pot, hand = nil)
    @pot = pot
    @hand = hand || Hand.new
  end

  def get_discard
    puts "Which cards would you like to discard: (ex. 1,3,5)"
    discards = gets.chomp
    parsed = discards.split(',').map { |index| index.to_i - 1 }

    raise ArgumentError unless parsed.all? { |el| el.between?(0, 4) } || parsed.length > 3

    @hand.discard(*parsed)
  end

  def get_bet
    puts "How much would you like to bet: (ex. 300)"
    bet_amount = gets.chomp.to_i

    raise ArgumentError if bet_amount > @pot

    @pot -= bet_amount
    bet_amount
  end

  def get_decision
    puts "What would you like to do?: (r, f, s)"
    choice = gets.chomp
    case choice
    when 'r'
      :raise
    when 's'
      :see
    when 'f'
      :fold
    end
  end
end
