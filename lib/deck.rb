require_relative "card"

class Deck
  attr_reader :cards

  def initialize
    @cards = generate_cards
  end

  private

  def generate_cards
    cards = []
    [:diamonds, :spades, :clubs, :hearts].each do |suit|
      (1..13).each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards
  end
end
