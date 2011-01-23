# coding: utf-8

class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])

    # let's assume we don't have multibyte mixing, øåß are skipped intentionally

    m = /[a-zA-Z]/.match(@game.letters)

    if !m
      @game.row_letters = @game.letters.mb_chars.length / 2
    else
      @game.row_letters = @game.letters.mb_chars.length
    end

    # to avoid ruby 1.8 vs 1.9 issues in Heroku, we should count non-ASCII chars in string,
    # and add number of such bytes to overall length
    # all by myself, oh dear


    if @game.save

      volume = @game.row_letters * (@game.row_letters - 1)

      @game.letters = ''.ljust(volume, '-') # create String of pre-defined amount of chars
      @game.letters = @game.letters.insert(@game.row_letters * (@game.row_letters / 2), params[:game][:letters].mb_chars)

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

    letters = @game.letters.mb_chars
    letters[params[:position].to_i-1] = params[:letter].mb_chars

    if @game.update_attributes!(:letters => letters.mb_chars) # not saved for some reason? SQLite?
      render :text => @game.letters
    end
  end

end