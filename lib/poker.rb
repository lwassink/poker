require_relative 'deck'
require_relative 'player'

class Poker
  attr_reader :players, :current_player, :deck, :pot

  def initialize(*players)
    @players = players
    @current_player = 0
    @deck = Deck.new
    @deck.shuffle!
    @pot = 0
    @current_bet = 0
    @players_in_round = @players.dup
  end

  def play
    play_round until over?
  end

  def play_round
    @players_in_round = @players.dup
    deal
    round_of_bets
    replace_cards
    round_of_bets
    resolve_round
  end

  def round_of_bets
    @current_bet = 0
    @players_in_round.each do |player|
      case player.get_decision
      when :raise
        @current_bet = player.get_raise(@current_bet)
        @pot += @current_bet
      when :see
        @pot += @current_bet
        player.make_bet(@current_bet)
      when :fold
        @players_in_round.delete(player)
      end
    end
  end

  private

  def deal
    @players.each do |player|
      5.times { player.hand << @deck.deal_card }
    end
  end

  def over?
    @players.count == 1
  end

  def replace_cards
    @players_in_round.each do |player|
      num = player.get_discard
      num.times { player.hand << @deck.deal_card }
    end
  end

  def resolve_round
    @players.delete_if { |player| player.pot <= 0 }
    winner.pay(@pot)
    @pot = 0
    rotate_players
  end

  def rotate_players
    @current_player = (@current_player + 1) % @players.length
  end

  def winner
    @players_in_round.sort_by(&:hand).last
  end
end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new(500)
  player2 = Player.new(500)
  game = Poker.new(player1, player2)
  game.play
end
