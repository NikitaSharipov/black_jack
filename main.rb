require_relative 'black_jack.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'card.rb'
require_relative 'text_interface.rb'

# Проверка очков дилера и игрока
# def much_points_dealer? (dealer)
#   dealer.points_count > 21
# end
#
# def much_points_player? (player)
#   player.points_count > 21
# end

# Метод подсчета очков и вывода на экран
def result_count(player, dealer, interface)
  if (player.points_count > dealer.points_count && player.points_count < 22) || dealer.points_count > 21
    player.money += 20
    winner = 'player'
  elsif player.points_count == dealer.points_count || player.points_count > 21 && dealer.points_count > 21
    player.money += 10
    dealer.money += 10
    winner = 'draw'
  else
    dealer.money += 20
    winner = 'dealer'
  end
  interface.point_count_text(winner, dealer)
end

# Ход дилера
def dealer_turn(dealer, interface)
  if dealer.points_count < 17 && dealer.cards.length < 3
    dealer.take_one_more_card
  end
  interface.dealer_turn_text(dealer)
end

# Изьятие ставок
def bet(player, dealer)
  player.money -= 10
  dealer.money -= 10
end

# Обработка хода пользователя
def player_turn(player, dealer, interface)
  loop do
    interface.player_turn_text

    input_loop2 = gets.to_i

    if input_loop2 == 1
      dealer_turn(dealer, interface) 
    end

    if input_loop2 == 2
      if player.cards.length < 3
        player.take_one_more_card
        interface.your_cards(player)
        interface.your_points(player)
      else
        interface.count_warning
      end

      dealer_turn(dealer, interface)

    end

    result_count(player, dealer, interface) if input_loop2 == 3

    if dealer.cards.length == 3 && player.cards.length == 3
      input_loop2 = 3
      result_count(player, dealer, interface)
    end

    break if input_loop2 == 3
  end
end

# Вывод карт
def card_to_string(black_jack)
  black_jack.cards.each do |card|
    print black_jack.value_to_string[card.value]
    puts black_jack.suit_to_string[card.suit]
  end
end

# Начало

interface = TextInterface.new
interface.name_text

input_name = gets.chomp


player = Player.new(input_name)
dealer = Dealer.new

loop do
  interface.how_much_money(player, dealer)

  player.take_2cards
  dealer.take_2cards

  interface.your_cards(player)

  interface.your_points(player)

  interface.hidden_dealer_card

  interface.text_bet

  bet(player, dealer)

  player_turn(player, dealer, interface)

  interface.text_end_menu

  input = gets.to_i

  break if input.zero?
end

# rubocop:enable Metrics/BlockLength
