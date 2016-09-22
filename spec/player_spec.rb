require "spec_helper"

describe Player do
  subject(:player) { Player.new(1000) }

  let(:ace_of_hearts) { Card.new(:hearts, 14) }
  let(:ace_of_clubs) { Card.new(:clubs, 14) }
  let(:ace_of_spades) { Card.new(:spades, 14) }
  let(:ace_of_diamonds) { Card.new(:diamonds, 14) }
  let(:king_of_spades) { Card.new(:spades, 13)}
  let(:four_aces) do
    hand = Hand.new([ace_of_spades, ace_of_diamonds, ace_of_clubs, ace_of_hearts, king_of_spades])
  end
  let(:player_with_cards) do
    Player.new(1000, four_aces)
  end

  describe "#initialize" do
    it "starts with a pot of 1000" do
      expect(player.pot).to eq(1000)
    end

    it "starts with an empty hand" do
      expect(player.hand.cards).to be_empty
    end
  end

  describe "#get_discard" do
    it "discards some cards" do
      expect(player_with_cards).to receive(:gets).and_return("1,2,3")
      player_with_cards.get_discard
      expect(player_with_cards.hand.cards).to eq([ace_of_hearts, king_of_spades])
    end

    it "raises an error when given invalid input" do
      expect(player_with_cards).to receive(:gets).and_return("1,2,7")
      expect { player_with_cards.get_discard }.to raise_error(ArgumentError)
    end
  end

  describe "#make_bet" do
    it "removes the bet from the pot" do
      player.make_bet(500)
      expect(player.pot).to eq(500)
    end
  end

  describe "#get_raise" do
    context "normal function" do
      before(:each) { expect(player).to receive(:gets).and_return("300") }
      it "returns the bet amount" do
        expect(player.get_raise(100)).to eq(400)
      end

      it "decrements the pot by the amount" do
        player.get_raise(100)
        expect(player.pot).to eq(600)
      end
    end

    it "raises an error when bet is larger than pot" do
      expect(player).to receive(:gets).and_return("3000")
      expect { player.get_raise(100) }.to raise_error(ArgumentError)
    end
  end

  describe "#get_decision" do
    it "raises if given 'r'" do
      expect(player).to receive(:gets).and_return("r")
      expect(player.get_decision).to eq(:raise)
    end

    it "raises if given 'f'" do
      expect(player).to receive(:gets).and_return("f")
      expect(player.get_decision).to eq(:fold)
    end

    it "raises if given 's'" do
      expect(player).to receive(:gets).and_return("s")
      expect(player.get_decision).to eq(:see)
    end
  end

  describe "#pay" do
    it "increments the player's pot" do
      player.pay(5000)
      expect(player.pot).to eq(6000)
    end
  end

end
