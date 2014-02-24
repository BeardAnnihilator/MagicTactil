# Setup the production environment

def main
  begin
    exec('bundle exec gem install mysql2 --no-ri --no-rdoc --platform=ruby -- --with-mysql-dir=C:/mysql-connector-c-6.1.3-win32 && ruby db_setup/mysql.rb && ruby db_setup/mysql_test.rb && echo "***** MYSQL INSTALLATION IS SUCCESSFUL *****"')
  rescue  SystemCallError => e
    puts e.message  
    puts e.backtrace.inspect  
  end
end

main