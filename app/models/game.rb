# encoding: utf-8

class Game < ActiveRecord::Base
  has_many :users, :through => 'games_users'
  validates :letters, :uniqueness => true, :presence => true, :length => { :minimum => 5, :message => " count is too small" }
  # validates_format_of :letters, :with => /\A[a-zA-Zа-яА-ЯøØåÅ]+\z/u, :message => "only allowed"

  validates :row_letters, :numericality => true
end
