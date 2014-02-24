require 'logger'

<<<<<<< .mine
#$logger = Logger.new("log/logfile_#{Time.now}.log")
=======
path = "log/logfile.log"
file = File.new(path, "w+")
$logger = Logger.new(file)
>>>>>>> .r630

def log_info(message)
	#$logger.info("#{Time.now}:  #{message}")
end

def log_error(message)
	#$logger.error("#{Time.now}: #{message}")
end