require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = [*('A'..'Z')].sample(10)
  end

  def score
    @grid = params[:grid]
    @user_answer = params[:answer]
    run_game(@user_answer, @grid)
  end
end

private

def word_exist?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  if json['found']
    @score = word.size
    @message = "Congratulations! #{word.upcase} is a valid English word! Your score is #{@score}"
  else
    @message = "Sorry but #{word.upcase} does not seem to be a valid English word..."
  end
end

def run_game(word, grid)
  if word.upcase.split("").all? { |letter| grid.include? letter }
    word_exist?(word)
  else
    @message = "Sorry but #{word.upcase} can't be built out of #{displayed_grid} !"
  end
end
