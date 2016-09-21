require "spec_helper"

describe Deck do
  subject(:deck) { Deck.new }

  describe "#initialize" do
    it "contains 52 cards" do
      expect(deck.cards.length).to eq(52)
    end

    it "contains the ace of diamonds" do
      expect(deck.cards).to include(Card.new(:diamonds, 1))
    end
  end

end
