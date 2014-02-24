require 'rubygems'
require 'yaml'
require 'active_record'
require './config/initializer/logger.rb'  

# ActiveRecord::Base.establish_connection(
# :adapter=> "mysql2",  
# :host => "localhost",
# :username => "root",
# :password => "root",  
# :database=> "bdd_magictactil"
# )

ActiveRecord::Base.establish_connection(  
  :adapter=> "sqlite3",
  :database=> "bdd_magictactil.sqlite3" 
)
  
class User < ActiveRecord::Base  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :events
  has_many :items

  validates :username, :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 6, maximum: 20 }
  validates :email,  format: { with: VALID_EMAIL_REGEX }
end

class Event < ActiveRecord::Base
  belongs_to :user
  validates :creator, :name, :creatorEmail, :description, :date, :location, presence: true
  validates :name, uniqueness: true
end

# Liste des joueurs dans un event
class Subscriber < ActiveRecord::Base
  validates :idEvent, :idUser, presence: true 
end

class Room < ActiveRecord::Base
end

# Liste des joueurs dans la room
class Roomplayer < ActiveRecord::Base
end

class Cards < ActiveRecord::Base
end

class Images < ActiveRecord::Base
end

class Deck < ActiveRecord::Base
end

class Decksta < ActiveRecord::Base
end

class Friendblacklist < ActiveRecord::Base
  validates :username, :belongsto, presence: true
end

class Deckcard < ActiveRecord::Base#; ActiveRecord::Relation
end

class Shop < ActiveRecord::Base
  has_many :items
end

class Item < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user
end
