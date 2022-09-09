class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @respuesta = params[:respuesta]
    @letters = params[:letters]
    @message = 'The word is not in english'

    if word_exist(@respuesta) && valid_grid?(@respuesta, @letters)
      @message = 'Congrats! This word exists'
    else
      @message = 'This word does not exist in english'
    end
  end

  def word_exist(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result_serialized = URI.open(url).read
    result = JSON.parse(result_serialized)
    result['found']
  end

  def valid_grid?(word, grid)
    word.upcase.chars.all? { |char| grid.include?(char) && word.upcase.count(char) <= grid.count(char) }
  end
end
