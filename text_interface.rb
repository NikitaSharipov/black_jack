class TextInterface

  def name_text
    puts 'Введите имя'
    input_name = gets.chomp
  end

  def how_much_money(player_money, dealer_money)
    puts "У вас #{player_money} $"
    puts "У дилера #{dealer_money} $"
  end


  def text_bet
    puts 'Дилер и игрок делают ставки по 10$'
  end

  def text_end_menu
    loop do
      puts 'Хотите сыграть еще?'
      puts '0. Нет, закончим игру!'
      puts '1. Да, конечно!'
      input = gets.to_i
      return input if input == 0 || input == 1
      puts 'Введены неверные данные'
    end
  end

end
