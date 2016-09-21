require 'spec_helper'

describe Hand do
  subject(:hand) { Hand.new }
  let(:card) { Card.new(:diamonds, 2) }
  let(:heart_card) { Card.new(:hearts, 4) }
  let(:card_hand) do
    hand = Hand.new
    hand << card
    hand << heart_card
    hand
  end

  let(:ace_of_hearts) { Card.new(:hearts, 14) }
  let(:ace_of_clubs) { Card.new(:clubs, 14) }
  let(:ace_of_spades) { Card.new(:spades, 14) }
  let(:ace_of_diamonds) { Card.new(:diamonds, 14) }
  let(:king_of_spades) { Card.new(:spades, 13)}
  let(:four_aces) do
    hand = Hand.new([ace_of_spades, ace_of_diamonds, ace_of_clubs, ace_of_hearts, king_of_spades])
  end

  let(:two_of_hearts) { Card.new(:hearts, 2) }
  let(:two_of_clubs) { Card.new(:clubs, 2) }
  let(:two_of_spades) { Card.new(:spades, 2) }
  let(:two_of_diamonds) { Card.new(:diamonds, 2) }
  let(:three_of_clubs) { Card.new(:clubs, 3) }
  let(:four_twos) do
    hand = Hand.new([two_of_hearts, two_of_spades, two_of_diamonds, two_of_clubs, three_of_clubs])
  end

  let(:two_of_hearts) { Card.new(:hearts, 2) }
  let(:five_of_hearts) { Card.new(:hearts, 5) }
  let(:six_of_hearts) { Card.new(:hearts, 6) }
  let(:jack_of_hearts) { Card.new(:hearts, 11) }
  let(:queen_of_hearts) { Card.new(:hearts, 12) }
  let(:flush) do
    hand = Hand.new([two_of_hearts, five_of_hearts, six_of_hearts, jack_of_hearts, queen_of_hearts])
  end

  let(:five_of_clubs) { Card.new(:clubs, 5) }
  let(:six_of_hearts) { Card.new(:hearts, 6) }
  let(:seven_of_hearts) { Card.new(:hearts, 7) }
  let(:eight_of_spades) { Card.new(:spades, 8) }
  let(:nine_of_hearts) { Card.new(:hearts, 9) }
  let(:straight_nine_high) do
    hand = Hand.new([five_of_clubs, six_of_hearts, seven_of_hearts, eight_of_spades, nine_of_hearts])
  end

  let(:four_of_hearts) { Card.new(:hearts, 4) }
  let(:five_of_clubs) { Card.new(:clubs, 5) }
  let(:six_of_hearts) { Card.new(:hearts, 6) }
  let(:seven_of_diamonds) { Card.new(:diamonds, 7) }
  let(:eight_of_spades) { Card.new(:spades, 8) }
  let(:straight_eight_high) do
    hand = Hand.new([four_of_hearts, five_of_clubs, six_of_hearts, seven_of_diamonds, eight_of_spades])
  end

  let(:two_of_hearts) { Card.new(:hearts, 2) }
  let(:five_of_clubs) { Card.new(:clubs, 5) }
  let(:two_of_spades) { Card.new(:spades, 2) }
  let(:two_of_diamonds) { Card.new(:diamonds, 2) }
  let(:three_of_clubs) { Card.new(:clubs, 3) }
  let(:three_of_a_kind) do
    hand = Hand.new([two_of_hearts, five_of_clubs, two_of_spades, two_of_diamonds, three_of_clubs])
  end

  describe "#initialize" do
    it "has no cards" do
      expect(hand.cards).to be_empty
    end
  end

  describe "#<<" do
    it "adds a card to the hand" do
      hand << card
      expect(hand.cards).to eq([card])
    end
  end

  describe "#discard" do
    it "removes a single card" do
      card_hand.discard(0)
      expect(card_hand.cards).to eq([heart_card])
    end

    it "removed multiple cards" do
      card_hand.discard(0, 1)
      expect(card_hand.cards).to be_empty
    end
  end

  describe "#<=>" do
    context "compare within types" do
      it "four aces beats four twos" do
        expect(four_aces <=> four_twos).to eq(1)
      end

      it "straight (nine high) beats straight (eight high)" do
        expect(straight_nine_high <=> straight_eight_high).to eq(1)
      end
    end

    context "compare between types" do
      it "four of a kind beats flush" do
        expect(four_aces <=> flush).to eq(1)
      end

      it "flush beats straight_nine_high" do
        expect(flush <=> straight_nine_high).to eq(1)
      end

      it "straight_nine_high beats three_of_a_kind" do
        expect(straight_nine_high <=> three_of_a_kind).to eq(1)
      end
    end
  end
end
