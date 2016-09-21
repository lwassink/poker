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

  describe "#shuffle!" do
    it "rearanges the order of the cards" do
      shuffled_deck = Deck.new
      shuffled_deck.shuffle!

      expect(shuffled_deck.cards).not_to eq(deck.cards)
    end

  end

  describe "#deal_card" do
    it "returns the top (first) card" do
      top_card = deck.cards.first
      expect(deck.deal_card).to eq(top_card)
    end

    it "shrinks the cards by one" do
      deck.deal_card
      expect(deck.cards.length).to be(51)
    end
  end

  describe "#empty?" do
    it "returns true if empty" do
      52.times { deck.deal_card }
      expect(deck.empty?).to be true
    end
  end
end
