require_relative File.dirname($0) + '/student_list_controller.rb'
require_relative File.dirname($0) + './persons/student.rb'

class Controller_insert < Student_list_controller

	def initialize(student_list)
		super(student_list)
	end
	 
	def create_student(student)
		stud = Student.new(id:0,surname:student["surname"],name:student["name"],lastname:student["lastname"],phone:student["phone"],telegram:student["telegram"],mail:student["mail"],git: student["git"])
		@student_list.push_student(stud)
		refresh_data(self.student_list_view.num_page,self.student_list_view.count_records)
	end
end