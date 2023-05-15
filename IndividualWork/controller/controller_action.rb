
require 'logger'

class Controller_action
	attr_writer :view
	def initialize(parent_controller,log_mode = :all,log_file)
		self.logger = Logger.new(log_file)
    	case log_mode
    		when :errors
      			self.logger.level = Logger::ERROR
    		when :hybrid
      			self.logger.level = Logger::INFO
    		else
      			self.logger.level = Logger::DEBUG
    	end
		@controller = parent_controller
	end
	 
	private 
	attr_reader :view
	attr_accessor :logger
end