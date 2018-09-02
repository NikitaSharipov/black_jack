class Deck
  attr_accessor :values, :suits, :cards

  def initialize
    @suits = %i[heart diamond club spade]
    @values = %i[ace king queen jack ten nine eight seven six five four three two]
    @cards = []
    @suits.each do |suit|
      @values.each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  def sample_card
    card = @cards.sample
    @cards.delete(card)
    card
  end
end
