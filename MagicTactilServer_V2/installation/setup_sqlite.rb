# Setup the production environment

def main
  begin
    exec('gem install bundler --no-ri --no-rdoc && bundle install && ruby db_setup/sqlite.rb && ruby db_setup/sqlite_test.rb && echo "***** SQLITE INSTALLATION IS SUCCESSFUL *****"')
  rescue  SystemCallError => e
    puts e.message  
    puts e.backtrace.inspect  
  end
end

main