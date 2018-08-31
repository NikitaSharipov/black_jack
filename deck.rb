class Deck

  attr_accessor :values, :suits, :deck

  def initialize
    @suits = %i[heart diamond club spade]
    @values = %i[ace king queen jack ten nine eight seven six five four three two]
    @deck = []
    deck_change
  end
  
  def deck_change
    @deck = []
    @suits.each do |suit|
      @values.each do |value|
        @deck << Card.new(suit,value)
      end
    end
  end

  def cart_remove(card)
    @deck.delete(card)
  end

  def take_cart_from_deck
    card = @deck.sample 
    cart_remove(card)
    return card
  end

end
