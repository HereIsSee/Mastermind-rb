
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

  def computer_select
    Array.new(4).map { COLORS[rand(0..5)] }
  end

  def guess_feedback guess_array
    black_pegs = number_of_black_pegs(guess_array)
    white_pegs = number_of_white_pegs(guess_array)
    white_pegs-= black_pegs
    { number_of_black_pegs: black_pegs, number_of_white_pegs: white_pegs}
  end

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