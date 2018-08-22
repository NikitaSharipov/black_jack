require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'card.rb'

# player = Player.new('Jake')
# dealer = Dealer.new
# 
# card = Card.new()
# card2 = Card.new()
# 
# player.get_one_more_card


  puts 'Введите имя'
  input_name = gets.chomp

  player = Player.new(input_name)
  dealer = Dealer.new
loop do 
  player.get_2cards
  dealer.get_2cards
  puts 'Ваши карты:'
  player.card_to_string
  puts 'Ваши очки:'
  puts player.points_count
  
  puts 'Карты Дилера'
  puts '**'
  puts '**'

  puts 'Дилер и игрок делают ставки по 10$'

  player.money -= 10
  dealer.money -= 10

  prize_fund = 20

  puts 'Ваш ход, выбирете вариант:'

  puts '1. Пропустить ход'
  puts '2. Добавить карту'
  puts '3. Открыть карты'

  input = gets.to_i

  if input == 1

  end

  if input == 2
    player.get_one_more_card
    puts 'Ваши новые карты:'
    player.card_to_string
    puts 'Ваши очки:'
    puts player.points_count   
  end
  
  if input == 3
    puts 'Карты Дилера'
    dealer.card_to_string
    if player.points_count > dealer.points_count && player.points_count < 22
      puts 'Вы победили, 20$ переходят к вам'
    elsif player.points_count == dealer.points_count || (player.points_count > 21 && dealer.points_count > 21)
      puts 'Ничья, деньги возвращаются их владельцам'
    else
      puts 'Вы проиграли, 20$, уходят дилеру'
    end
  end

  break if input.zero?
end

