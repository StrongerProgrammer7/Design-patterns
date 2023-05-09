require_relative File.dirname($0) + './datatable/students_list.rb'

class Student_Adapter
	
	@@addressFile = "/testfile"
	@@nameFile = "test"
		
	def initialize(format_file)
		@student_list_file = Students_list.new(format_file)
	end
	
	def get_student_by_id(id)
		@student_list_file.get_student_by_id(id)
	end

	def get_k_n_student_short_list(k,n,data_list:nil)
		@student_list_file.get_k_n_student_short_list(k,n,data_list:data_list)
	end
	
	def get_student_short_count()
		@student_list_file.get_student_short_count()
	end

	def push_student(student)
		@student_list_file.push_student(student)	
		@student_list_file.write_to_file(@@addressFile,@@nameFile,@student_list_file.list_students)
	end

	def replace_element_by_id(id,element)
		@student_list_file.replace_element_by_id(id,element)
		@student_list_file.write_to_file(@@addressFile,@@nameFile,@student_list_file.list_students)
	end

	def delete_element_by_id(id)
		@student_list_file.delete_element_by_id(id)
		@student_list_file.write_to_file(@@addressFile,@@nameFile,@student_list_file.list_students)
	end

	
end