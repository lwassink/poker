require "spec_helper"

describe Card do
  subject(:card) { Card.new(:clubs, 3) }

  describe "#initialize" do
    it "has a suit" do
      expect(card.suit).to eq(:clubs)
    end

    it "has a value" do
      expect(card.value).to eq(3)
    end
  end

  describe "#<=>" do
    let(:other_card) { Card.new(:hearts, 10) }

    it "orders cards by value" do
      expect(card <=> other_card).to eq(-1)
    end
  end

  describe "#to_s" do
    let(:face_card) { Card.new(:hearts, 12) }
    it "correctly prints cards of numeric value" do
      expect(card.to_s).to eq("3 of clubs")
    end

    it "correctly prints face cards" do
      expect(face_card.to_s).to eq("queen of hearts")
    end
  end

  describe "#==" do
    it "knows two different objects are the same card" do
      another_card = Card.new(:clubs, 3)
      expect(card).to eq(another_card)
    end
  end
end
