class Card
  attr_accessor :value, :suit

  @@suit = %i[heart diamond club spade]
  @@value = %i[ace king queen jack ten nine eight seven six five four three two]

  def initialize
    @value = @@value.sample
    @suit = @@suit.sample
  end
end
