# coding: utf-8

class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])

    if @game.save

      @game.row_letters = @game.letters.length
      volume = @game.row_letters * @game.row_letters

      # wtf?
      @game.letters = ''.ljust(volume+1, '•')

      @game.letters[volume/2] = params[:game][:letters]
      @game.save!

      render :text => 'Game successfully created!<br />'+@game.letters
    else
      render :text => 'Game was not created!'
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def delete
  end

  def join
  end

  def leave
  end

  def finish
  end

  def skipturn
  end

  def newturn
  end

end
