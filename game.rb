require_relative 'player.rb'
require_relative 'card_deal.rb'
require_relative 'card.rb'
require_relative 'text_interface.rb'
require_relative 'deck.rb'
require_relative 'text_card_deal_interface.rb'

class Game
  def initialize
    main_game
  end

  def main_game
    interface = TextInterface.new
    interface_card_deal = TextCardDealInterface.new
    input_name = interface.name_text

    player = Player.new(input_name)
    dealer = Player.new('Dealer')

    game_deck = Deck.new

    loop do
      interface.how_much_money(player.money, dealer.money)
      card_deal = CardDeal.new

      interface.text_bet

      bet(player, dealer)

      card_deal.round(game_deck, interface_card_deal)

      give_prize(card_deal.winner, player, dealer)

#      player.take_2cards(game_deck)
#      dealer.take_2cards(game_deck)
#      interface.your_cards(player.card_to_interface)
#      interface.your_points(player.points_count)
#      interface.hidden_dealer_card

      input = interface.text_end_menu

      break if input.zero?

      game_deck.deck_change
    end
  end

=begin
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
    interface.point_count_text(winner, dealer.card_to_interface)
  end
  =end

  # Ход дилера
#  def dealer_turn(dealer, interface, game_deck)
#    dealer.take_one_more_card(game_deck) if dealer.points_count < 17 && dealer.cards.length < 3
#    interface.dealer_turn_text(dealer.cards)
#  end
=end

  # Изьятие ставок
  def bet(player, dealer)
    player.money -= 10
    dealer.money -= 10
  end

  def give_prize(winner, player, dealer)
    if winner == 'player'
      player.money += 20
    elsif winner == 'draw'
      player.money += 10
      dealer.money += 10
    elsif winner ==  'dealer'
      dealer.money += 20 
    end
  end

=begin
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
          interface.your_cards(player.card_to_interface)
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
=end
end
