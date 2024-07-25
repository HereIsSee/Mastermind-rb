require_relative 'lib/mastermind.rb'

game = MasterMind.new

puts game.anwser_array

puts game.guess_feedback ['red', 'blue', 'green', 'yellow']