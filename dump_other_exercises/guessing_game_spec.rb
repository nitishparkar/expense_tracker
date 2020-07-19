#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'guessing_game'
require 'stringio'

module Mountain
  RSpec.describe GuessingGame do
    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:subject) { GuessingGame.new(10, output, input) }

    context 'when you guess correctly' do
      it 'prints success message' do
        input.string = '10'

        subject.play

        expect(output.string).to eq("Pick a number 1-100 (5 guesses left):\nYou won!\n")
      end
    end

    context 'when you do not guess correctly and the guess is higher' do
      it 'prints instructions accordingly' do
        input.string = "11\n10"

        subject.play

        expect(output.string).to eq("Pick a number 1-100 (5 guesses left):\n11 is too high!\nPick a number 1-100 (4 guesses left):\nYou won!\n")
      end
    end

    context 'when you do not guess correctly and the guess is lower' do
      it 'prints instructions accordingly' do
        input.string = "9\n10"

        subject.play

        expect(output.string).to eq("Pick a number 1-100 (5 guesses left):\n9 is too low!\nPick a number 1-100 (4 guesses left):\nYou won!\n")
      end
    end

    context 'when you lose' do
      it 'prints failure message' do
        input.string = "9\n11\n11\n11\n11\n11\n11\n"

        subject.play

        expect(output.string).to eq("Pick a number 1-100 (5 guesses left):\n9 is too low!\nPick a number 1-100 (4 guesses left):\n11 is too high!\nPick a number 1-100 (3 guesses left):\n11 is too high!\nPick a number 1-100 (2 guesses left):\n11 is too high!\nPick a number 1-100 (1 guesses left):\n11 is too high!\nYou lost! The number was: 10\n")
      end
    end
  end
end
