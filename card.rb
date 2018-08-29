class Card
  attr_accessor :value, :suit

  def initialize(deck_exempl)
    deck_exempl.deck.sample.each do |inner_hash|
      @suit ||= inner_hash[:suit]
      @value ||= inner_hash[:value] 
    end
    deck_exempl.cart_remove([{suit: @suit},{value: @value}])
  end
end
