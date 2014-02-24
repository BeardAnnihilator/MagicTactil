require_relative '../Protocol.rb'
require_relative '../lib/packet.rb'

require 'active_record'  

I18n.enforce_available_locales = false

ActiveRecord::Base.establish_connection(  
 :adapter => "sqlite3",
 :database => "test.sqlite3" 
 )

# ActiveRecord::Base.establish_connection(
# :adapter=> "mysql2",  
# :host => "localhost",
# :username => "root",
# :password => "root",  
# :database=> "test_magictactil"
# )