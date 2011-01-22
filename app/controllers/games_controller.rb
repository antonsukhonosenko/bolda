# coding: utf-8

class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    @game.row_letters = @game.letters.length

    if @game.save

      volume = @game.row_letters * (@game.row_letters - 1)

      @game.letters = ''.ljust(volume+1, '-') # create String of pre-defined amount of chars
      @game.letters[@game.row_letters * (@game.row_letters/2)] = params[:game][:letters]

      @game.save!

      flash[:notice] = 'Game successfully created!'
      redirect_to :action => 'show', :id => @game.id
    else
      render :action => 'new'
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

  def letter  # shit of a hell. mysql doesn't set up. sqlite doesn't SAVE db saying it does
    @game = Game.find(params[:game])

    letters = @game.letters
    letters[params[:position].to_i-1] = params[:letter]

    if @game.update_attributes!(:letters => letters) # not saved for some reason? SQLite?
      render :text => params[:position].to_i-1 # letters
    end
  end

end