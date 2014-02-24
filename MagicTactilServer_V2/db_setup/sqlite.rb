require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'bdd_magictactil.sqlite3' # :memory:
)

 db = SQLite3::Database.new( "bdd_magictactil.sqlite3" )

 
ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'users'
    create_table :users do |table|
      table.column :email, :string
      table.column :username, :string
      table.column :name, :string
      table.column :givenname, :string
      table.column :birthday, :date
      table.column :location, :string
      table.column :password, :string
      table.column :telephone, :string
      table.column :gender, :string
      table.column :roomstatus, :string
      table.column :state, :string
      table.column :id_event, :int
    end
  end

    unless ActiveRecord::Base.connection.tables.include? 'subscribers'
      create_table :subscribers do |table|
      table.column :idEvent, :int
      table.column :idUser, :int
      end
    end

    unless ActiveRecord::Base.connection.tables.include? 'rooms'
      create_table :rooms do |table|
        table.column :nameOwner, :string
        table.column :format, :string
        table.column :nameRoom, :string
        table.column :password, :string
        table.column :state, :string
        table.column :nbPlayer, :int
        table.column :maxSize, :int
      end
    end

       unless ActiveRecord::Base.connection.tables.include? 'roomplayers'
      create_table :roomplayers do |table|
        table.column :idUser, :int
        table.column :idRoom, :int
      end
    end

    unless ActiveRecord::Base.connection.tables.include? 'friendblacklists'
      create_table :friendblacklists do |table|
        table.column :username, :string
        table.column :belongsto, :string
        table.column :typelist, :string
      end
    end

    unless ActiveRecord::Base.connection.tables.include? 'decks'
      create_table(:decks, :primary_key => "idDeck") do |table|
        table.column :nameOwner, :string
        table.column :deckName, :string
        table.column :isReal, :boolean       
      end
    end

    unless ActiveRecord::Base.connection.tables.include? 'deckcards'
      create_table(:deckcards) do |table|
        table.column :idDeck, :integer
        table.column :idCard, :integer
        table.column :nbCard, :integer
        table.column :isSided, :boolean
      end
    end


    unless ActiveRecord::Base.connection.tables.include? 'events'
      create_table :events do |table|
        table.column :creator, :string
        table.column :name, :string
        table.column :creatorEmail, :string
        table.column :description, :text
        table.column :idUser, :int
        table.column :date, :date
        table.column :location, :string
      end
    end   
end

class User < ActiveRecord::Base  
end

alex = User.new()
alex.username = "alex"
alex.email = "periph_a@epitech.eu"
alex.password = "123456"
alex.name = "periphanos"
alex.givenname = "alexandre"
alex.save

mick = User.new()
mick.username = "mick"
mick.email = "pucheu_m@epitech.eu"
mick.password = "123456"
mick.name = "pucheu"
mick.givenname = "mickael"
mick.save

meh = User.new()
meh.username = "mehdi"
meh.email = "farsi_m@epitech.eu"
meh.password = "123456"
meh.name = "farsi"
meh.givenname = "mehdi"
meh.save

oual = User.new()
oual.username = "oualid"
oual.email = "jouhri_o@epitech.eu"
oual.password = "123456"
oual.name = "jouhri"
oual.givenname = "oualid"
oual.save

luc = User.new()
luc.username = "lucas"
luc.email = "ortis_l@epitech.eu"
luc.password = "123456"
luc.name = "ortis"
luc.givenname = "lucas"
luc.save

ben = User.new()
ben.username = "benjamin"
ben.email = "labori_b@epitech.eu"
ben.password = "123456"
ben.name = "laborier"
ben.givenname = "benjamin"
ben.save