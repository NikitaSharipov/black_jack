class Dealer
  attr_accessor :money
  attr_reader :cards, :points, :value_to_string, :suit_to_string

  def initialize
    @money = 100
    @card_points = { ace: 0, king: 10, queen: 10, jack: 10, ten: 10, nine: 9, eight: 8, seven: 7, six: 6, five: 5, four: 4, three: 3, two: 2 }
    @suit_to_string = { heart: '<3', diamond: '<>', club: '+', spade: '^' }
    @value_to_string = { ace: 'T', king: 'K', queen: 'Q', jack: 'J', ten: '10', nine: '9', eight: '8', seven: '7', six: '6', five: '5', four: '4', three: '3', two: '2' }
  end

  def how_many_ace
    @cards.select { |card| card.value == :ace }.count
  end

  def take_2cards(player_deck)
    @cards = [Card.new(player_deck), Card.new(player_deck)]
  end

  def take_one_more_card(player_deck)
    card3 = Card.new(player_deck)
    @cards << card3
  end

  def points_count
    @points = 0
    @cards.each do |card|
      @points += @card_points[card.value]
    end

    if how_many_ace == 3
      @points = 13
    elsif how_many_ace == 2
      if @points < 10
        @points += 12
      else
        @poitns += 2
      end
    elsif how_many_ace == 1
      @points = if points < 11
                  @points + 11
                else
                  @points + 1
                end
    end
    @points
  end
end
