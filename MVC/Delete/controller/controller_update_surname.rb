require_relative File.dirname($0) + './view/student_list_view.rb'
require_relative File.dirname($0) + './student_DB/student_list_DB.rb'
require_relative File.dirname($0) + './student_list/student_list.rb'
require_relative File.dirname($0) + './datatable/data_list_student_short.rb'
require_relative File.dirname($0) + '/student_list_controller.rb'

class Controller_get < Student_list_controller

	def initialize(student_list)
		super(student_list)
	end
	

end