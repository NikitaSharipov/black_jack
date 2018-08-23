require_relative 'black_jack.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'card.rb'

# Проверка очков дилера и игрока
def much_points_dealer? (dealer)
  dealer.points_count > 21
end

def much_points_player? (player)
  player.points_count > 21
end

# Метод подсчета очков и вывода на экран
def result_count(player, dealer)
  puts 'Карты Дилера'
  dealer.card_to_string
  if  (player.points_count > dealer.points_count && player.points_count < 22) || much_points_dealer?(dealer)
    puts 'Вы победили, 20$ переходят к вам'
    player.money += 20
  elsif player.points_count == dealer.points_count || (much_points_player?(player) && much_points_dealer?(dealer))
    puts 'Ничья, деньги возвращаются их владельцам'
    player.money += 10
    dealer.money += 10
  else
    puts 'Вы проиграли, 20$, уходят дилеру'
    dealer.money += 20
  end
end

# Ход дилера
def dealer_turn(dealer)
  if dealer.points_count < 17 && dealer.cards.length < 3
    puts 'Дилер взял еще 1 карту'
    dealer.take_one_more_card
  else
    puts 'Дилер пропускает ход'
    end
end

# Начало

puts 'Введите имя'
input_name = gets.chomp

player = Player.new(input_name)
dealer = Dealer.new

# rubocop:disable Metrics/BlockLength

loop do
  puts "У вас #{player.money} $"
  puts "У дилера #{dealer.money} $"

  player.take_2cards
  dealer.take_2cards
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

  loop do
    puts 'Ваш ход, выбирете вариант:'

    puts '1. Пропустить ход'
    puts '2. Добавить карту'
    puts '3. Открыть карты'

    input_loop2 = gets.to_i

    if input_loop2 == 1
      dealer_turn(dealer)
    end

    if input_loop2 == 2
      if player.cards.length < 3
        player.take_one_more_card
        puts 'Ваши новые карты:'
        player.card_to_string
        puts 'Ваши очки:'
        puts player.points_count
      else
        puts 'У вас уже 3 карты, вы не можете взять еще 1'
      end

      dealer_turn(dealer)

    end

    result_count(player, dealer) if input_loop2 == 3

    if dealer.cards.length == 3 && player.cards.length == 3
      input_loop2 = 3
      result_count(player, dealer)
    end

    break if input_loop2 == 3
  end

  puts 'Хотите сыграть еще?'
  puts '0. Нет, закончим игру!'
  puts '1. Да, конечно!'

  input = gets.to_i

  break if input.zero?
end

# rubocop:enable Metrics/BlockLength

def l
  puts much_points_dealer?(20)
  puts much_points_player?(22)
end

l
