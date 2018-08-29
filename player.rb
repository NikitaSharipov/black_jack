class Player < Dealer
  attr_accessor :name

  def initialize(name)
    super()
    @name = name
  end
end
