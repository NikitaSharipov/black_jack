require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'card.rb'

player = Player.new('Jake')
dealer = Dealer.new

card = Card.new()
card2 = Card.new()

player.get_one_more_card

puts player.points_count


