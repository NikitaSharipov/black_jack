class Dealer
  attr_accessor :money
  attr_reader :cards

  def initialize 
    @money = 100
  end

  def get_2cards
    card1 = Card.new()
    card2 = Card.new()
    @cards = []
    @cards << card1
    @cards << card2
  end

end
