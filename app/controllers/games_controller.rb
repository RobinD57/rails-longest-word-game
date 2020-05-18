require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a[rand(26)] }.join
    @start_time = Time.now
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]
    @start_time = Time.parse(params[:start_time])
    @end_time = Time.now
    @final_score, @message = start_game(@answer, @letters)
  end

  def start_game(answer, letters)
    time_answer = @start_time - @end_time
    word_validity = valid?(answer)
    final_message(answer, letters, word_validity, time_answer)
  end

  private

  def point_calculation(answer, time_answer)
    time_answer > 100 ? 0 : answer.length * (1.0 - time_answer / 60.0)
  end

  def included?(answer, letters)
    answer.split(//).all? { |letter| letters.include?(letter) }
  end

  def final_message(answer, letters, valid, time)
    if valid?(answer)
      if included?(answer.upcase, letters)
        points = point_calculation(letters, time)
        [points, 'yay!']
      else
        [0, "Used letters that aren't part of the given sequence"]
      end
    else
      [0, 'Not an English word!']
    end
  end

  def valid?(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{answer.downcase}")
    json = JSON.parse(response.string)
    json['found']
  end
end
