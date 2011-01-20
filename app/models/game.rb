class Game < ActiveRecord::Base
  has_many :users, :through => 'games_users'
  validates :letters, :uniqueness => true, :presence => true, :length => { :minimum => 5 }
end
