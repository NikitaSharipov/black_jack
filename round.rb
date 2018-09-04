class Round
  attr_reader :winner, :bank

  CARDPOINTS = { ace: 0, king: 10, queen: 10, jack: 10, ten: 10, nine: 9, eight: 8, seven: 7, six: 6, five: 5, four: 4, three: 3, two: 2 }
  SUITTOSTRING = { heart: '<3', diamond: '<>', club: '+', spade: '^' }
  VALUETOSTRING = { ace: 'T', king: 'K', queen: 'Q', jack: 'J', ten: '10', nine: '9', eight: '8', seven: '7', six: '6', five: '5', four: '4', three: '3', two: '2' }

  def initialize(interface, bank)
    @player_cards = []
    @dealer_cards = []
    @deck = Deck.new
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
  attr_accessor :player_cards, :dealer_cards, :deck, :interface, :dealer_points, :player_points

  def how_many_ace(cards)
    cards.select { |card| card.value == :ace }.count
  end

  def points_count(cards)
    points = 0
    cards.each do |card|
      points += CARDPOINTS[card.value]
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
      text_card << [VALUETOSTRING[card.value], SUITTOSTRING[card.suit]]
    end
    text_card
  end

  def dealer_turn
    take = false
    if points_count(@dealer_cards) < 17 && @dealer_cards.length < 3
      @dealer_cards << @deck.sample_card
      take = true
    end
    @interface.dealer_turn_text(take)
  end

  def player_turn
    if @player_cards.length < 3
      @player_cards << @deck.sample_card
      @interface.your_cards(card_to_interface(@player_cards))
      @interface.your_points(points_count(@player_cards))
    else
      @interface.count_warning
    end
  end

  # Обработка хода пользователя
  def turn
    loop do
      decision = @interface.player_turn_text

      case decision

      when :wait
        dealer_turn

      when :take_card
        player_turn
        dealer_turn

      when :open_card
        result_count
      end

      if @dealer_cards.length == 3 && @player_cards.length == 3
        decision = :open_card
        result_count
      end

      break if decision == :open_card
    end
  end

  def result_count
    @player_points = points_count(player_cards)
    @dealer_points = points_count(dealer_cards)

    @winner = if (@player_points > @dealer_points && @player_points < 22) || (@player_points < 22 && @dealer_points > 21)
                'player'
              elsif @player_points == @dealer_points || @player_points > 21 && @dealer_points > 21
                'draw'
              else
                'dealer'
              end
    @interface.dealer_cards_text(card_to_interface(dealer_cards))
  end
end
