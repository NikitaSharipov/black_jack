class TextInterface

  def name_text
    puts 'Введите имя'
  end

  def how_much_money(player, dealer)
    puts "У вас #{player.money} $"
    puts "У дилера #{dealer.money} $"
  end

  def your_cards(player)
    puts 'Ваши карты:'
    card_to_string(player)
  end

  def your_points(player)
    puts 'Ваши очки:'
    puts player.points_count
  end

  def hidden_dealer_card
    puts 'Карты Дилера'
    puts '**'
    puts '**'
  end

  def text_bet
    puts 'Дилер и игрок делают ставки по 10$'
  end

  def text_end_menu
    puts 'Хотите сыграть еще?'
    puts '0. Нет, закончим игру!'
    puts '1. Да, конечно!'
  end

  def point_count_text(winner, dealer)
    puts 'Карты Дилера'
    card_to_string(dealer)
    if winner == 'player'
      puts 'Вы победили, 20$ переходят к вам'
    elsif winner == 'dealer'
      puts 'Вы проиграли, 20$, уходят дилеру'
    elsif winner == 'draw'
      puts 'Ничья, деньги возвращаются их владельцам'
    end
  end

  def dealer_turn_text (dealer) 
    if dealer.cards.length == 3
      puts 'Дилер взял еще 1 карту'
    else
      puts 'Дилер пропускает ход'
    end 
  end

  def player_turn_text
    puts 'Ваш ход, выбирете вариант:'

    puts '1. Пропустить ход'
    puts '2. Добавить карту'
    puts '3. Открыть карты'
  end

  def count_warning
    puts 'У вас уже 3 карты, вы не можете взять еще 1'
  end
end
