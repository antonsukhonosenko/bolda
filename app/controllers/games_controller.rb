# coding: utf-8

require 'rubygems'
require 'iconv'

class String
  def force_encoding(enc)
    ::Iconv.conv('UTF-8//IGNORE', 'UTF-8', self + ' ')[0..-2]
  end
end

class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    @game.row_letters = @game.letters.force_encoding('UTF-8').size

    if @game.save

      volume = @game.row_letters * (@game.row_letters - 1)

      @game.letters = ''.ljust(volume, '-') # create String of pre-defined amount of chars
      @game.letters = @game.letters.insert(@game.row_letters * (@game.row_letters / 2), params[:game][:letters].force_encoding('UTF-8'))

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

    letters = @game.letters.force_encoding('UTF-8')
    letters[params[:position].to_i-1] = params[:letter].force_encoding('UTF-8')

    if @game.update_attributes!(:letters => letters.force_encoding('UTF-8')) # not saved for some reason? SQLite?
      render :text => @game.letters
    end
  end

end