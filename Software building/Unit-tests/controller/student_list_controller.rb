require_relative File.dirname($0) + './view/student_list_view.rb'
require_relative File.dirname($0) + './student_list/student_list.rb'
require_relative File.dirname($0) + './datatable/data_list_student_short.rb'

class Student_list_controller
	attr_writer :student_list_view
	attr_reader :data_list_student_short

	def initialize(student_list)
		@student_list = student_list
	end

	def refresh_data(k,n)
		if(self.data_list_student_short==nil) then
			self.data_list_student_short = @student_list.get_k_n_student_short_list(k,n,data_list:self.data_list_student_short)
		else
			@student_list.get_k_n_student_short_list(k,n,data_list:self.data_list_student_short)
		end
		self.data_list_student_short.student_list_view = self.student_list_view if self.data_list_student_short.student_list_view == nil
		self.data_list_student_short.notify(n)
		self.student_list_view.show(PLACEMENT_SCREEN)
	end

	def get_count_student_short()
		@student_list.get_student_short_count
	end

	def select_student(num)
		self.data_list_student_short.select(num)
	end

	def get_selected()
		self.data_list_student_short.get_selected()
	end

	def get_student_by_id(id)
		@student_list.get_student_by_id(id)
	end

	def delete_student()
		list_student = get_selected()
		list_student.each do |id_student|
			@student_list.delete_element_by_id(id_student)
		end 
		
	end

	private 
	attr_reader :student_list_view
	attr_writer :data_list_student_short

	
	
end