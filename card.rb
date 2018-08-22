class Card
  attr_accessor :value, :suit

  @@suit = [:heart, :diamond, :club, :spade]
  @@value = [:ace, :king, :queen, :jack, :ten, :nine, :eight, :seven, :six, :five, :four, :three, :two]
#  @@value = [ace: 11, king: 10, queen: 10, jack: 10, ten: 10, nine: 9, eight: 8, seven: 7, six: 6, five: 5, four: 4, three: 3, two: 2]
#  @@points = [ace: 11, king: 10, queen: 10, jack: 10, ten: 10, nine: 9, eight: 8, seven: 7, six: 6, five: 5, four: 4, three: 3, two: 2]

  def initialize()
#    @value = @@value.sample
    @value = @@value.sample
    @suit = @@suit.sample
  end

end
