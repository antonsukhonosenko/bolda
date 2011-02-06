# encoding: utf-8

class Game < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :letters, :uniqueness => true, :presence => true, :length => { :minimum => 5, :message => " count is too small" }
  # validates_format_of :letters, :with => /\A[a-zA-Zа-яА-ЯøØåÅ]+\z/u, :message => "only allowed"

  validates :row_letters, :numericality => true
end
