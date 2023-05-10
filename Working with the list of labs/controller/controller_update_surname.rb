require_relative File.dirname($0) + './model_student/persons/student.rb'

require 'logger'

class Controller_update_surname
	attr_writer :student_list_view
	def initialize(student_list,parent_controller,log_mode = :all)
		@student_list = student_list
		self.logger = Logger.new("logger/log_update.txt")
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
	
	def get_student_by_id(id)
		@student_list.get_student_by_id(id)
	end

	def update_student(student)
		self.logger.debug("Updating student with ID #{student["id"]} and params #{student}")
		self.logger.info("Updating student with ID #{student["id"]} and params #{student}")
		stud = Student.new(id:student["id"],surname:student["surname"],name:student["name"],lastname:student["lastname"],phone:student["phone"],telegram:student["telegram"],mail:student["mail"],git: student["git"])
		@student_list.replace_element_by_id(stud.id,stud)
		@controller.refresh_data(self.student_list_view.num_page,self.student_list_view.count_records)
	rescue => e
		self.logger.error("Error while updating student with ID #{student["id"]}: #{e}")
	end
	private 
	attr_reader :student_list_view
	attr_accessor :logger
end
	