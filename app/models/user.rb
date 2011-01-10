class User < ActiveRecord::Base
  has_many :games, :through => 'games_users'
end
