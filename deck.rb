class Deck
  attr_accessor :values, :suits, :deck

  def initialize
    @suits = %i[heart diamond club spade]
    @values = %i[ace king queen jack ten nine eight seven six five four three two]
    @deck = []
    @suits.each do |suit|
      @values.each do |value|
        @deck << Card.new(suit, value)
      end
    end
  end

  def cart_remove(card)
    @deck.delete(card)
  end

  def sample_card
    card = @deck.sample
    cart_remove(card)
    card
  end
end
