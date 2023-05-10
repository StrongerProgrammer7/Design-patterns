require_relative File.dirname($0) + './model_student/persons/student.rb'

require 'logger'

class Controller_insert
	attr_writer :student_list_view
	def initialize(student_list,parent_controller,log_mode = :all)
		@student_list = student_list
		self.logger = Logger.new("logger/log_create.txt")
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
	 
	def create_student(student)
		self.logger.debug("Creating student with params #{student}")
		self.logger.info("Creating student with params #{student}")
		stud = Student.new(id:0,surname:student["surname"],name:student["name"],lastname:student["lastname"],phone:student["phone"],telegram:student["telegram"],mail:student["mail"],git: student["git"])
		@student_list.push_student(stud)
		@controller.refresh_data(self.student_list_view.num_page,self.student_list_view.count_records)
	rescue => e
		self.logger.error("Error while creating student: #{e}")
	end

	private 
	attr_reader :student_list_view
	attr_accessor :logger
end