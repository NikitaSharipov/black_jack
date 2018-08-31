class Player
  attr_accessor :money, :name
  attr_reader :cards, :points, :value_to_string, :suit_to_string

  def initialize(name)  
    @name = name
    @money = 100
#    @card_points = { ace: 0, king: 10, queen: 10, jack: 10, ten: 10, nine: 9, eight: 8, seven: 7, six: 6, five: 5, four: 4, three: 3, two: 2 }
#    @suit_to_string = { heart: '<3', diamond: '<>', club: '+', spade: '^' }
#    @value_to_string = { ace: 'T', king: 'K', queen: 'Q', jack: 'J', ten: '10', nine: '9', eight: '8', seven: '7', six: '6', five: '5', four: '4', three: '3', two: '2' }
  end
=begin
  def how_many_ace
    @cards.select { |card| card.value == :ace }.count
  end

  def take_2cards(player_deck)
    @cards = [player_deck.take_cart_from_deck, player_deck.take_cart_from_deck]
  end

  def take_one_more_card(player_deck)
    @cards << player_deck.take_cart_from_deck
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

  def card_to_interface
    text_card_hash = {}
    @cards.each do |card|
      text_card_hash[@value_to_string[card.value]] = @suit_to_string[card.suit]
    end
    text_card_hash
  end
=end
end
