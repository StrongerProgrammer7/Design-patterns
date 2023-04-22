require_relative File.dirname($0) + '/datatable/students_list.rb'

class Student_Adapter
	
	addressFile = "/students/"
	nameFile = "test_students"
		
	def initialize(strategy)
		@strategy = strategy
	end
	
	def get_student_by_id(id)
		@strategy.get_student_by_id(id)
	end

	def get_k_n_student_short_list(k,n,data_list:nil)
		@strategy.get_k_n_student_short_list(k,n,data_list)
	end
	
	def get_student_short_count()
		@strategy.get_student_short_count()
	end

	def push_student(student)
		@strategy.push_student(student)	
		@strategy.write_to_file(addressFile,nameFile,@strategy.list_students)
	end

	def replace_element_by_id(id,element)
		@strategy.replace_element_by_id(id,element)
		@strategy.write_to_file(addressFile,nameFile,@strategy.list_students)
	end

	def delete_element_by_id(id)
		@strategy.delete_element_by_id(id)
		@strategy.write_to_file(addressFile,nameFile,@strategy.list_students)
	end

	
end