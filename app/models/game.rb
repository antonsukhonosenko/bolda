class Game < ActiveRecord::Base
  has_many :users, :through => 'games_users'
end
