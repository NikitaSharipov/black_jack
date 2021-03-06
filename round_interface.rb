class RoundInterface

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

  def dealer_cards_text(dealer_cards)
    puts 'Карты Дилера'
    card_to_string(dealer_cards)
  end

  def dealer_turn_text(take)
    if take
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
      input_loop = gets.to_i
      if input_loop == 1
        decision = :wait
      elsif input_loop == 2
        decision = :take_card
      elsif input_loop == 3
        decision = :open_card
      end
      return decision if input_loop.between?(1, 3)
      puts 'Введены неверные данные'
    end
  end

  def count_warning
    puts 'У вас уже 3 карты, вы не можете взять еще 1'
  end

  def card_to_string(card_hash)
    card_hash.each do |card|
      card.each { |value| print value }
      puts
    end
  end

  def player_turn_input
    input_loop2 = gets.to_i
  end
end
