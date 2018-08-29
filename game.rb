require_relative 'dealer.rb'
require_relative 'player.rb'
require_relative 'card.rb'
require_relative 'text_interface.rb'
require_relative 'deck.rb'

class Game
  def initialize
    main_game
  end

  def main_game
    interface = TextInterface.new
    input_name = interface.name_text

    player = Player.new(input_name)
    dealer = Dealer.new

    game_deck = Deck.new

    loop do
      interface.how_much_money(player, dealer)

      player.take_2cards(game_deck)
      dealer.take_2cards(game_deck)

      interface.your_cards(player)

      interface.your_points(player)

      interface.hidden_dealer_card

      interface.text_bet

      bet(player, dealer)

      player_turn(player, dealer, interface, game_deck)

      input = interface.text_end_menu

      break if input.zero?

      game_deck.deck_change
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
  def dealer_turn(dealer, interface, game_deck)
    dealer.take_one_more_card(game_deck) if dealer.points_count < 17 && dealer.cards.length < 3
    interface.dealer_turn_text(dealer)
  end

  # Изьятие ставок
  def bet(player, dealer)
    player.money -= 10
    dealer.money -= 10
  end

  # Обработка хода пользователя
  def player_turn(player, dealer, interface, game_deck)
    loop do
      input_loop2 = interface.player_turn_text

      if input_loop2 == 1
        dealer_turn(dealer, interface, game_deck)
      end

      if input_loop2 == 2
        if player.cards.length < 3
          player.take_one_more_card(game_deck)
          interface.your_cards(player)
          interface.your_points(player)
        else
          interface.count_warning
        end

        dealer_turn(dealer, interface, game_deck)

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
