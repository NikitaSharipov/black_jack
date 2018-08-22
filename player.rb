class Player
  attr_accessor :name, :money
  attr_reader :cards, :points

  @@points = {ace: 0, king: 10, queen: 10, jack: 10, ten: 10, nine: 9, eight: 8, seven: 7, six: 6, five: 5, four: 4, three: 3, two: 2}

  @@suit_to_string = {heart: '<3', diamond: '<>', club: '+', spade: '^'}
  @@value_to_string = {ace: 'T', king: 'K', queen: 'Q', jack: 'J', ten: '10', nine: '9', eight: '8', seven: '7', six: '6', five: '5', four: '4', three: '3', two: '2'}

  def initialize (name)
    @name = name
    @money = 100
  end

  def how_many_ace
    ace_count = 0
    @cards.each do |card|
      ace_count += 1 if card.value == :ace
    end
    ace_count
  end

  def get_2cards
    card1 = Card.new()
    card2 = Card.new()
    @cards = []
    @cards << card1
    @cards << card2
  end

  def get_one_more_card
    card3 = Card.new
    @cards << card3
  end

  def points_count
    @points = 0
    @cards.each do |card|
      @points += @@points[card.value]
    end

    if how_many_ace == 3
      @points = 13
    elsif how_many_ace == 2
      if @points < 10
        @points = @points + 12
      else 
        @poitns = @poitns +2
      end
    elsif how_many_ace == 1
      if points < 11
        @points = @points + 11
      else
        @points = @points + 1
      end
    end 
    @points
  end

  def card_to_string
    @cards.each do |card|
      print @@value_to_string[card.value]
      puts @@suit_to_string[card.suit]
    end
  end

end
