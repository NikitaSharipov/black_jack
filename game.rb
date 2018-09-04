class Game
  def initialize
    main_game
  end

  def main_game
    interface = TextInterface.new
    interface_card_deal = RoundInterface.new
    input_name = interface.name_text

    player = Player.new(input_name)
    dealer = Player.new('Dealer')

    loop do
      interface.how_much_money(player.money, dealer.money)

      bank = bet(player, dealer, 10)

      break if bank.nil?

      interface.text_bet(bank)

      card_deal = Round.new(interface_card_deal, bank)

      card_deal.round

      interface.point_count_text(card_deal.winner, bank)

      give_prize(card_deal.winner, player, dealer, card_deal.bank)

      input = interface.text_end_menu

      break if input.zero?
    end
  end

  # Изьятие ставок
  def bet(player, dealer, rate)
    if proceed?(player, dealer)
      player.money -= rate
      dealer.money -= rate
      bank = 2 * rate
    else
      puts 'Игра не может быть продолжена, один из участников не может сделать ставку'
    end
  end

  def proceed?(player, dealer)
    return false if player.money == 0 || dealer.money == 0
    true
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
