class CardDeal
  attr_reader :winner, :bank

  def initialize(deck, interface, bank)
    @card_points = { ace: 0, king: 10, queen: 10, jack: 10, ten: 10, nine: 9, eight: 8, seven: 7, six: 6, five: 5, four: 4, three: 3, two: 2 }
    @suit_to_string = { heart: '<3', diamond: '<>', club: '+', spade: '^' }
    @value_to_string = { ace: 'T', king: 'K', queen: 'Q', jack: 'J', ten: '10', nine: '9', eight: '8', seven: '7', six: '6', five: '5', four: '4', three: '3', two: '2' }
    @player_cards = []
    @dealer_cards = []
    @deck = deck
    @interface = interface
    @bank = bank
  end

  def round
    2.times do
      @player_cards << @deck.sample_card
      @dealer_cards << @deck.sample_card
    end

    @interface.your_cards(card_to_interface(@player_cards))
    @interface.your_points(points_count(@player_cards))
    @interface.hidden_dealer_card

    turn
  end

  protected

  attr_writer :winner
  attr_reader :cards, :value_to_string, :suit_to_string
  attr_accessor :player_cards, :dealer_cards, :deck, :interface

  def how_many_ace(cards)
    cards.select { |card| card.value == :ace }.count
  end

  def points_count(cards)
    points = 0
    cards.each do |card|
      points += @card_points[card.value]
    end

    if how_many_ace(cards) == 3
      points = 13
    elsif how_many_ace(cards) == 2
      if points < 10
        points += 12
      else
        poitns += 2
      end
    elsif how_many_ace(cards) == 1
      points = if points < 11
                 points + 11
               else
                 points + 1
                end
    end
    points
  end

  def card_to_interface(cards)
    text_card = []
    cards.each do |card|
      text_card << [@value_to_string[card.value], @suit_to_string[card.suit]]
    end
    text_card
  end

  def dealer_turn
    @dealer_cards << @deck.sample_card if points_count(@dealer_cards) < 17 && @dealer_cards.length < 3
    @interface.dealer_turn_text(@dealer_cards)
  end

  # Обработка хода пользователя
  def turn
    loop do
      input_loop2 = @interface.player_turn_text

      case input_loop2

      when 1
        dealer_turn

      when 2
        if @player_cards.length < 3
          @player_cards << @deck.sample_card
          @interface.your_cards(card_to_interface(@player_cards))
          @interface.your_points(points_count(@player_cards))
        else
          @interface.count_warning
        end
        dealer_turn

      when 3
        result_count

      end

      if @dealer_cards.length == 3 && @player_cards.length == 3
        input_loop2 = 3
        result_count
      end

      break if input_loop2 == 3
    end
  end

  def result_count
    if (points_count(player_cards) > points_count(dealer_cards) && points_count(player_cards) < 22) || points_count(dealer_cards) > 21
      @winner = 'player'
    elsif points_count(player_cards) == points_count(dealer_cards) || points_count(player_cards) > 21 && points_count(dealer_cards) > 21
      @winner = 'draw'
    else
      @winner = 'dealer'
    end
    @interface.dealer_cards_text(card_to_interface(dealer_cards))
  end
end
