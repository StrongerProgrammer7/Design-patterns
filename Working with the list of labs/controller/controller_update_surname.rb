require_relative File.dirname($0) + './datatable/data_list_student_short.rb'
require_relative File.dirname($0) + '/student_list_controller.rb'

class Controller_update_surname< Student_list_controller

	def initialize(student_list,log_mode = :all)
		super(student_list,log_mode)
	end
	 
	def update_student(student)
		self.logger.debug("Updating student with ID #{student["id"]} and params #{student}")
		self.logger.info("Updating student with ID #{student["id"]} and params #{student}")
		stud = Student.new(id:student["id"],surname:student["surname"],name:student["name"],lastname:student["lastname"],phone:student["phone"],telegram:student["telegram"],mail:student["mail"],git: student["git"])
		@student_list.replace_element_by_id(stud.id,stud)
		refresh_data(self.student_list_view.num_page,self.student_list_view.count_records)
	rescue => e
		self.logger.error("Error while updating student with ID #{student["id"]}: #{e}")
	end
end
	