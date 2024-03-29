require_relative File.dirname($0) + '/student_list_controller.rb'
require_relative File.dirname($0) + './persons/student.rb'

class Controller_update_surname< Student_list_controller

	def initialize(student_list)
		super(student_list)
	end
	 
	def update_student(student)
		stud = Student.new(id:student["id"],surname:student["surname"],name:student["name"],lastname:student["lastname"],phone:student["phone"],telegram:student["telegram"],mail:student["mail"],git: student["git"])
		@student_list.replace_element_by_id(stud.id,stud)
		refresh_data(self.student_list_view.num_page,self.student_list_view.count_records)
	end
end
	