# coding: utf-8

require 'rubygems'
require 'iconv'

class String
  def to_my_utf8
    ::Iconv.conv('UTF-8//IGNORE', 'UTF-8', self + ' ')[0..-2]
  end
end

class GamesController < ApplicationController

  before_filter :authenticate_user!, :except => [:login]

  def index
    # @things = current_user.things
  end


  def new
    @game = Game.new
  end

  def create
    params[:game][:letters] = params[:game][:letters].to_my_utf8

    @game = Game.new(params[:game])

    if @game.save

      volume = @game.row_letters * (@game.row_letters - 1)

      @game.letters = ''.ljust(volume, '-').to_my_utf8 # create String of pre-defined amount of chars
      @game.letters = @game.letters.to_my_utf8.insert(@game.row_letters * (@game.row_letters / 2), params[:game][:letters].to_my_utf8)

      @game.users << current_user

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

    # TODO: if letter position doesn't have any neighbours in 4 closest positions,
    # TODO: or theresn't a letter in params[:letter] at all -
    # TODO: then this is a fraud, ignore it

    letters = @game.letters.to_my_utf8
    letters[params[:position].to_i-1, 1] = params[:letter].to_my_utf8

    if @game.update_attributes!(:letters => letters.to_my_utf8) # not saved for some reason? SQLite?
      render :text => @game.letters.to_my_utf8
    end
  end

  def claimword
    render :text => params[:word]  # or 'error' if word is not correct
    # but, we should use state machine here, to better organize turns
  end

end