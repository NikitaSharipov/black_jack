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

    loop do
      game_deck = Deck.new
      interface.how_much_money(player.money, dealer.money)

      interface.text_bet

      bank = bet(player, dealer, 10)

      card_deal = CardDeal.new(game_deck, interface_card_deal, bank)

      card_deal.round

      interface.point_count_text(card_deal.winner)

      give_prize(card_deal.winner, player, dealer, card_deal.bank)

      input = interface.text_end_menu

      break if input.zero?
    end
  end

  # Изьятие ставок
  def bet(player, dealer, rate)
    player.money -= rate
    dealer.money -= rate
    bank = 2 * rate
  end

  def give_prize(winner, player, dealer, bank)
    if winner == 'player'
      player.money += bank
    elsif winner == 'draw'
      player.money += bank / 2
      dealer.money += bank / 2
    elsif winner == 'dealer'
      dealer.money += bank
    end
  end
end
