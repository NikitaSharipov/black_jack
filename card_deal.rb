class CardDeal
attr_accessor :winner, :player_cards, :dealer_cards
attr_reader :cards, :points, :value_to_string, :suit_to_string

  def initialize  
    @card_points = { ace: 0, king: 10, queen: 10, jack: 10, ten: 10, nine: 9, eight: 8, seven: 7, six: 6, five: 5, four: 4, three: 3, two: 2 }
    @suit_to_string = { heart: '<3', diamond: '<>', club: '+', spade: '^' }
    @value_to_string = { ace: 'T', king: 'K', queen: 'Q', jack: 'J', ten: '10', nine: '9', eight: '8', seven: '7', six: '6', five: '5', four: '4', three: '3', two: '2' }
  end

  def how_many_ace(cards)
    cards.select { |card| card.value == :ace }.count
  end

  def take_2cards(player_deck)
    @player_cards = [player_deck.take_cart_from_deck, player_deck.take_cart_from_deck]
    @dealer_cards = [player_deck.take_cart_from_deck, player_deck.take_cart_from_deck]
  end

  def take_one_card_dealer(player_deck)
    @dealer_cards << player_deck.take_cart_from_deck
  end

  def take_one_card_player(player_deck)
    @player_cards << player_deck.take_cart_from_deck
  end

  def points_count(cards)
    @points = 0
    cards.each do |card|
      @points += @card_points[card.value]
    end

    if how_many_ace(cards) == 3
      @points = 13
    elsif how_many_ace(cards) == 2
      if @points < 10
        @points += 12
      else
        @poitns += 2
      end
    elsif how_many_ace(cards) == 1
      @points = if points < 11
                  @points + 11
                else
                  @points + 1
                end
    end
    @points
  end

  def card_to_interface(cards)
    text_card_hash = {}
    cards.each do |card|
      text_card_hash[@value_to_string[card.value]] = @suit_to_string[card.suit]
    end
    text_card_hash
  end

  def round(player_deck, interface)
    take_2cards(player_deck)
    interface.your_cards(card_to_interface(@player_cards))
    interface.your_points(points_count(@player_cards))
    interface.hidden_dealer_card

    turn(interface, player_deck)
  end

  def dealer_turn(interface, game_deck)
    take_one_card_dealer(game_deck) if points_count(@dealer_cards) < 17 && @dealer_cards.length < 3
    interface.dealer_turn_text(@dealer_cards)
  end

  # Обработка хода пользователя
  def turn(interface, game_deck)
    loop do
      input_loop2 = interface.player_turn_text

      if input_loop2 == 1
        dealer_turn(interface, game_deck)
      end

      if input_loop2 == 2
        if @player_cards.length < 3
          take_one_card_player(game_deck)
          interface.your_cards(card_to_interface(@player_cards))
          interface.your_points(points_count(@player_cards))
        else
          interface.count_warning
        end

        dealer_turn(interface, game_deck)

      end

      result_count(interface) if input_loop2 == 3

      if @dealer_cards.length == 3 && @player_cards.length == 3
        input_loop2 = 3
        result_count(interface)
      end

      break if input_loop2 == 3
    end
  end

  def result_count(interface)
    if (points_count(player_cards) > points_count(dealer_cards) && points_count(player_cards) < 22) || points_count(dealer_cards) > 21
      @winner = 'player'
    elsif points_count(player_cards) == points_count(dealer_cards) || points_count(player_cards) > 21 && points_count.dealer_cards > 21
      @winner = 'draw'
    else
      @winner = 'dealer'
    end
    interface.point_count_text(@winner, card_to_interface(dealer_cards))
  end

end
