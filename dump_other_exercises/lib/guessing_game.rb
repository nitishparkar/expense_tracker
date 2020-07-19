#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
class GuessingGame
  def initialize(number = rand(1..100), stdout = $stdout, stdin = $stdin)
    @number = number
    @guess = nil
    @stdout = stdout
    @stdin = stdin
  end

  def play
    5.downto(1) do |remaining_guesses|
      @stdout.puts "Pick a number 1-100 (#{remaining_guesses} guesses left):"
      @guess = @stdin.gets.to_i
      check_guess
      break if @guess == @number
    end

    announce_result
  end

private

  def check_guess
    if @guess > @number
      @stdout.puts "#{@guess} is too high!"
    elsif @guess < @number
      @stdout.puts "#{@guess} is too low!"
    end
  end

  def announce_result
    if @guess == @number
      @stdout.puts 'You won!'
    else
      @stdout.puts "You lost! The number was: #{@number}"
    end
  end
end

# play the game if this file is run directly
GuessingGame.new.play if __FILE__.end_with?($PROGRAM_NAME)
