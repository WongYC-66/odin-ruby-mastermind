# solution.rb
require_relative "Game"
require_relative "GameAI"

puts("Welcome to game")
puts("A secret code of 4chars long is assigned, out of ABCDEF, e.g. \"ABCD\" ")

puts("Are you going to guess ? Y/N")
human_to_guess = gets.chomp.upcase
until human_to_guess == 'Y' || human_to_guess == 'N'
  puts("Are you going to guess ? Y/N")
  human_to_guess = gets.chomp.upcase
end

new_game = human_to_guess == 'Y' ? Game.new() : GameAI.new()
new_game.play