require_relative "hand"

class Player
  attr_reader :pot, :hand

  def initialize(pot, hand = nil)
    @pot = pot
    @hand = hand || Hand.new
  end

  def get_discard
    puts "Your current hand is: #{@hand}"
    puts "Which cards would you like to discard: (ex. 1,3,5)"
    discards = gets.chomp
    parsed = discards.split(',').map { |index| index.to_i - 1 }

    raise ArgumentError unless parsed.all? { |el| el.between?(0, 4) } || parsed.length > 3

    @hand.discard(*parsed)
    discards.length
  end

  def make_bet(amount)
    @pot -= amount
  end

  def get_raise(current_bet)
    puts "The current bet is: #{current_bet}"
    puts "How much would you like to raise: (ex. 300)"
    raise_amount = gets.chomp.to_i + current_bet

    raise ArgumentError if raise_amount > @pot

    @pot -= raise_amount
    raise_amount
  end

  def get_decision
    puts "Your current hand is: #{@hand}"
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

  def pay(amount)
    @pot += amount
  end
end
