
#The Mastermind game class where everything is kept
class MasterMind
  
  COLORS = ['red', 'blue', 'green', 'yellow', 'orange', 'purple']
  PEG_COLORS = ['white', 'black']

  attr_accessor :anwser_array

  def initialize ()
    @anwser_array = computer_select
    @guess_count = 12
  end

  def play
    @guess_count.downto(1) do |number_of_guesses_left|
      puts "Number of guesses left: #{number_of_guesses_left}"
      puts "Guesser, pick 4 colors from this list (can be repeated), with a number from 1 to 6"
      print COLORS; puts
      feedback = guess_feedback(pick_4_colors())
      puts "Black pegs: #{feedback[:number_of_black_pegs]}  White pegs: #{feedback[:number_of_white_pegs]}"
      if win?( feedback ) 
        return puts "You have guessed right! You WIN!"
      end  
    end
    puts "You have run out of guesses! You LOSE!"
  end

  def pick_4_colors
    Array.new(4).map do |value|
      loop do
        pick = gets.chomp.to_i
        if [1,2,3,4,5,6].include? pick
          value = COLORS[pick-1]
          break
        else
          puts "Wrong input, pick the color again!"
        end
      end
      value
    end
  end

  def computer_select
    Array.new(4).map { COLORS[rand(0..5)] }
  end

  def guess_feedback guess_array
    black_pegs = number_of_black_pegs(guess_array)
    white_pegs = number_of_white_pegs(guess_array)
    white_pegs-= black_pegs
    { number_of_black_pegs: black_pegs, number_of_white_pegs: white_pegs}
  end

  def win? peg_count
    return true if peg_count[:number_of_black_pegs] == 4
    false
  end


  private

  def number_of_white_pegs guess_array
    num = 0
    accounted_for_indexes = Array.new
    guess_array.each do |guess|
      @anwser_array.each_with_index do |anwser, index|
        if guess == anwser && !accounted_for_indexes.include?(index)
          num+=1 
          accounted_for_indexes.push index
          break
        end
      end
    end
    num
  end

  def number_of_black_pegs guess_array
    num = 0
    for i in 0..3 do
      num+=1 if guess_array[i] == @anwser_array[i]
    end
    num
  end
end