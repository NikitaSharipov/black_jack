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
        @deck << [{suit: suit}, {value: value}]
      end
    end
  end

  def cart_remove(card)
    @deck.delete(card)
  end

end
