require 'mysql2'
require 'active_record'  

@db_host = "localhost"
@db_user = "root"
@db_pass = "kokololo"
@db_name = "test_db"

client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_pass)
client.query("DROP DATABASE IF EXISTS #{@db_name}")
client.query("CREATE DATABASE #{@db_name}")
#client.close

ActiveRecord::Base.establish_connection(  
:adapter=> "mysql2",  
:host => "localhost",
:username => "root",
:password => "kokololo",
:database=> "test_db",
)

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

    unless ActiveRecord::Base.connection.tables.include? 'decks'
      create_table :decks do |table|
        table.column :nameOwner, :string
        table.column :deckName, :string
        table.column :isReal, :boolean
      end
      execute("alter table decks change id idDeck int")
      execute("alter table decks modify column idDeck int auto_increment")
    end

    unless ActiveRecord::Base.connection.tables.include? 'deckcards'
      create_table :deckcards do |table|
        table.column :idDeck, :int
        table.column :idCard, :int
        table.column :nbCard, :int
        table.column :isSided, :boolean
      end
      execute("alter table deckcards change id pId int")
      execute("alter table deckcards modify column pId int auto_increment")
    end
end

class User < ActiveRecord::Base  
end

alex = User.new()
alex.username = "alex"
alex.email = "periph_a@epitech.eu"
alex.password = "periphanos"
alex.name = "periphanos"
alex.givenname = "alexandre"
alex.state = "N"
alex.save

mick = User.new()
mick.username = "mick"
mick.email = "pucheu_m@epitech.eu"
mick.password = "pucheu"
mick.name = "pucheu"
mick.givenname = "mickael"
mick.state = "N"
mick.save

meh = User.new()
meh.username = "mehdi"
meh.email = "farsi_m@epitech.eu"
meh.password = "farsi"
meh.name = "farsi"
meh.givenname = "mehdi"
meh.state = "N"
meh.save

oual = User.new()
oual.username = "oualid"
oual.email = "jouhri_o@epitech.eu"
oual.password = "jouhri"
oual.name = "jouhri"
oual.givenname = "oualid"
oual.state = "N"
oual.save

luc = User.new()
luc.username = "lucas"
luc.email = "ortis_l@epitech.eu"
luc.password = "ortis"
luc.name = "ortis"
luc.givenname = "lucas"
luc.state = "N"
luc.save

ben = User.new()
ben.username = "benjamin"
ben.email = "labori_b@epitech.eu"
ben.password = "laborier"
ben.name = "laborier"
ben.givenname = "benjamin"
ben.state = "N"
ben.save
