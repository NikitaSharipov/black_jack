class TextCardDealInterface
  def initialize
    @suit_to_string = { heart: '<3', diamond: '<>', club: '+', spade: '^' }
    @value_to_string = { ace: 'T', king: 'K', queen: 'Q', jack: 'J', ten: '10', nine: '9', eight: '8', seven: '7', six: '6', five: '5', four: '4', three: '3', two: '2' }
  end

  def your_cards(card_to_interface)
    puts 'Ваши карты:'
    card_to_string(card_to_interface)
  end

  def your_points(player_points)
    puts 'Ваши очки:'
    puts player_points
  end

  def hidden_dealer_card
    puts 'Карты Дилера'
    puts '**'
    puts '**'
  end

  def point_count_text(winner, dealer_cards)
    puts 'Карты Дилера'
    card_to_string(dealer_cards)
    if winner == 'player'
      puts 'Вы победили, 20$ переходят к вам'
    elsif winner == 'dealer'
      puts 'Вы проиграли, 20$, уходят дилеру'
    elsif winner == 'draw'
      puts 'Ничья, деньги возвращаются их владельцам'
    end
  end

  def dealer_turn_text(dealer_cards)
    if dealer_cards.length == 3
      puts 'Дилер взял еще 1 карту'
    else
      puts 'Дилер пропускает ход'
    end
  end

  def player_turn_text
    loop do
      puts 'Ваш ход, выбирете вариант:'
      puts '1. Пропустить ход'
      puts '2. Добавить карту'
      puts '3. Открыть карты'
      input_loop2 = gets.to_i
      return input_loop2 if input_loop2.between?(1, 3)
      puts 'Введены неверные данные'
    end
  end

  def count_warning
    puts 'У вас уже 3 карты, вы не можете взять еще 1'
  end

  def card_to_string(card_hash)
    card_hash.each do |key, value|
      print key
      puts value
    end
  end

  def player_turn_input
    input_loop2 = gets.to_i
  end
end
