require "spec_helper"

describe Poker do
  before(:each) do
    player1 = double("Player", :get_decision => :raise, :get_raise => 100)
    player2 = double("Player", :get_decision => :see, :make_bet => nil)
    @poker = Poker.new(player1, player2)
  end

  describe "#initialize" do
    it "has two players" do
      expect(@poker.players.length).to eq(2)
    end

    it "sets the current player" do
      expect(@poker.current_player).to eq(0)
    end

    it "has a deck" do
      expect(@poker.deck).to be_a(Deck)
    end

    it "sets pot to zero" do
      expect(@poker.pot).to eq(0)
    end
  end

  # describe "#resolve_hand" do
  #   it ""
  # end

  describe "#round_of_bets" do
    it "correctly increments pot" do
      @poker.round_of_bets
      expect(@poker.pot).to eq(200)
    end
  end
end
