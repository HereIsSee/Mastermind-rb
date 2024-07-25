
#The Mastermind game class where everything is kept
class MasterMind
  #6 colors, 4 spots to fill

  #show how right you are by giving white if correct color,
  #black if correct color and position otherwise nothing
  COLORS = ['red', 'blue', 'green', 'yellow', 'orange', 'purple']
  PEG_COLORS = ['white', 'black']

  def initialize ()
    @color_array 
    @guess_count = 12
  end

  def computer_select
    Array.new(4).map { COLORS[rand(0..5)] }
  end


end