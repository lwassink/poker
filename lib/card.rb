class Card
  FACE_VALUES = {
    11 => "jack",
    12 => "queen",
    13 => "king",
    14 => "ace"
  }
  attr_reader :suit, :value
  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def <=>(card)
    @value <=> card.value
  end

  def to_s
    case @value
    when (2..10)
      print_value = @value.to_s
    else
      print_value = FACE_VALUES[@value]
    end
    "#{print_value} of #{@suit}"
  end

  def ==(card)
    @suit == card.suit && @value == card.value
  end

  def inspect
    to_s
  end
end
