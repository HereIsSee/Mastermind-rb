
#The Mastermind game class where everything is kept
class MasterMind
  #6 colors, 4 spots to fill

  #show how right you are by giving white if correct color,
  #black if correct color and position otherwise nothing
  COLORS = ['red', 'blue', 'green', 'yellow', 'orange', 'purple']
  PEG_COLORS = ['white', 'black']

  attr_accessor :anwser_array

  def initialize ()
    @anwser_array = computer_select
    @guess_count = 12
  end

  def play
    puts "Guesser, pick 4 colors from this list (can be repeated), with a number from 1 to 6"
    print COLORS; puts
    colors_picked = pick_4_colors()
    print colors_picked; puts
    puts guess_feedback(colors_picked)

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




  private

  def number_of_white_pegs guess_array
    num = 0
    guess_array.each do |guess|
      @anwser_array.each do |anwser|
        if guess == anwser
          num+=1 
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