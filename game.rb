require_relative 'black_jack.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'card.rb'
require_relative 'text_interface.rb'

class Game
  def initialize
    main_game
  end

  def main_game
    interface = TextInterface.new
    input_name = interface.name_text

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

      input = interface.text_end_menu

      break if input.zero?
    end
  end

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
    dealer.take_one_more_card if dealer.points_count < 17 && dealer.cards.length < 3
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
      input_loop2 = interface.player_turn_text

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
end
