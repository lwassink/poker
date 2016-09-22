class Hand
  include Comparable

  attr_reader :cards

  def initialize(cards = nil)
    @cards = cards || []
  end

  def <<(card)
    @cards << card
  end

  def discard(*positions)
    @cards.delete_if.with_index { |_, index| positions.include? index }
  end

  def <=>(hand)
    if type != hand.type
      hand.type <=> type
    else
      compare_within_type(hand, type)
    end
  end

  def to_s
    @cards.join(", ")
  end

  protected

  def type
    return 1 if is_straight_flush?
    return 2 if is_four_of_a_kind?
    return 3 if is_full_house?
    return 4 if is_flush?
    return 5 if is_straight?
    return 6 if is_three_of_a_kind?
    return 7 if is_two_pair?
    return 8 if is_pair?
    9
  end

  def cards_by_value
    groups = @cards.group_by(&:value).values
    groups.sort_by { |group| [group.length, group.first] }.reverse
  end

  private

  def highest_card
    cards.max
  end

  def is_straight_flush?
    is_straight? && is_flush?
  end

  def is_four_of_a_kind?
    cards_by_value.any? { |group| group.length == 4 }
  end

  def is_full_house?
    cards_by_value.length == 2
  end

  def is_flush?
    count_suit(@cards.first.suit) == 5
  end

  def is_straight?
    sorted = @cards.sort
    (0..3).all? { |i| sorted[i].value + 1 == sorted[i+1].value }
  end

  def is_three_of_a_kind?
    cards_by_value.length == 3 && cards_by_value.any? { |group| group.length == 3 }
  end

  def is_two_pair?
    cards_by_value.length == 3
  end

  def is_pair?
    cards_by_value.length == 4
  end

  def count_value(value)
    @cards.count { |card| card.value == value }
  end

  def count_suit(suit)
    @cards.count { |card| card.suit == suit }
  end

  def compare_within_type(hand, type)
    case type
    when 2, 3, 6
      self_group = cards_by_value.first.first
      hand_group = hand.cards_by_value.first.first
      self_group <=> hand_group
    when 8
      self_group = cards_by_value.first.first
      hand_group = hand.cards_by_value.first.first

      pair_comparison = self_group <=> hand_group
      return pair_comparison unless pair_comparison == 0

      highest_unequal_card(hand)
    when 7
      first_self_pair, second_self_pair = cards_by_value
      first_hand_pair, second_hand_pair = hand.cards_by_value

      first_pair_comparison = first_self_pair.first <=> first_hand_pair.first
      return first_pair_comparison unless first_pair_comparison == 0
      second_pair_comparison = second_self_pair.first <=> second_hand_pair.first
      return second_pair_comparison unless second_pair_comparison == 0

      highest_unequal_card(hand)
    when 1, 4, 5, 9
      highest_unequal_card(hand)
    end
  end

  def highest_unequal_card(hand)
    sorted_self = @cards.sort.reverse
    sorted_hand = hand.cards.sort.reverse
    5.times do |i|
      comparison = sorted_self[i] <=> sorted_hand[i]
      return comparison unless comparison == 0
    end
    0
  end

end
