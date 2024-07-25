# The Mastermind game class where everything is kept
class MasterMind
  COLORS = %w[red blue green yellow orange purple]

  attr_accessor :anwser_array

  def initialize
    @anwser_array # rubocop:disable Lint/Void
    @guess_count = 12
  end

  def play
    puts "Play as 'guesser'(1) or 'secret code creator'(2)"
    loop do
      anwser = gets.chomp.to_i
      if ![1, 2].include?(anwser)
        puts 'Invalid anwser! Try again!'
      else
        play_player_guesser if anwser == 1
        play_player_secret_code_creator if anwser == 2
        break
      end
    end
  end

  def play_player_secret_code_creator
    puts 'Select 4 colors (can be repeated) that will be the code, with the numbers from 1 to 6'
    print COLORS
    puts
    @anwser_array = pick_4_colors

    robot_array = Array.new(4).map { COLORS[rand(0..5)] }
    (@guess_count - 1).downto(1) do |number_of_guesses_left|
      puts "Number of guesses left: #{number_of_guesses_left}"
      computer_guess_update(robot_array)
      feedback = guess_feedback(robot_array)
      puts "Black pegs: #{feedback[:number_of_black_pegs]}  White pegs: #{feedback[:number_of_white_pegs]}"
      return puts 'You have guessed right! You WIN!' if win?(feedback)
    end
    puts 'You have run out of guesses! You LOSE!'
  end

  def play_player_guesser
    @anwser_array = computer_select
    @guess_count.downto(1) do |number_of_guesses_left|
      puts "Number of guesses left: #{number_of_guesses_left}"
      puts 'Guesser, pick 4 colors from this list (can be repeated), with the numbers from 1 to 6'
      print COLORS
      puts
      feedback = guess_feedback(pick_4_colors)
      puts "Black pegs: #{feedback[:number_of_black_pegs]}  White pegs: #{feedback[:number_of_white_pegs]}"
      return puts 'You have guessed right! You WIN!' if win?(feedback)
    end
    puts 'You have run out of guesses! You LOSE!'
  end

  def computer_guess_update(array_of_colors)
    array_of_colors.each_with_index do |value, index|
      if @anwser_array.include?(value) && array_of_colors[index] != @anwser_array[index] &&
         guess_feedback(array_of_colors)[:number_of_black_pegs] != 3
        change_correct_color_position(array_of_colors, index)
      elsif array_of_colors[index] != @anwser_array[index]
        change_color_at_index(array_of_colors, index)
      end
    end
  end

  def change_color_at_index(array_of_colors, index)
    loop do
      value = COLORS[rand(0..5)]
      if value != array_of_colors[index]
        array_of_colors[index] = value
        break
      end
    end
  end

  def change_correct_color_position(array_of_colors, index)
    loop do
      num = rand(0..3)
      next unless array_of_colors[num] != @anwser_array[num] && num != index

      color = array_of_colors[index]
      array_of_colors[index] = array_of_colors[num]
      array_of_colors[num] = color
      break
    end
    array_of_colors
  end

  def pick_4_colors
    Array.new(4).map do |value|
      pick_color(value)
    end
  end

  def pick_color(value)
    loop do
      pick = gets.chomp.to_i
      if [1, 2, 3, 4, 5, 6].include? pick
        value = COLORS[pick - 1]
        break
      else
        puts 'Wrong input, pick the color again!'
      end
    end
    value
  end

  def computer_select
    Array.new(4).map { COLORS[rand(0..5)] }
  end

  def guess_feedback(guess_array)
    black_pegs = number_of_black_pegs(guess_array)
    white_pegs = number_of_white_pegs(guess_array)
    white_pegs -= black_pegs
    { number_of_black_pegs: black_pegs, number_of_white_pegs: white_pegs }
  end

  def win?(peg_count)
    return true if peg_count[:number_of_black_pegs] == 4

    false
  end

  private

  def number_of_white_pegs(guess_array)
    num = 0
    accounted_for_indexes = []
    guess_array.each do |guess|
      @anwser_array.each_with_index do |anwser, index|
        next unless guess == anwser && !accounted_for_indexes.include?(index)

        num += 1
        accounted_for_indexes.push index
        break
      end
    end
    num
  end

  def number_of_black_pegs(guess_array)
    num = 0
    (0..3).each do |i|
      num += 1 if guess_array[i] == @anwser_array[i]
    end
    num
  end
end
