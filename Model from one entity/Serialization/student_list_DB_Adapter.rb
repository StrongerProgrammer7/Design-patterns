require_relative File.dirname($0) + '/Student_list.rb'

class Student_list_DB_Adapter < Student_list
	def initialize(database)
		@database = database
	end

	def get_student_by_id(id)
		@database.get_student_by_id(id)
	end

	def get_k_n_student_short_list(k,n,data_list:nil)
		@database.get_k_n_student_short_list(k,n,data_list)
	end

	def push_student(student)
		@database.push_student(student)
	end

	def replace_element_by_id(id,element)
		@database.replace_element_by_id(id,element)
	end

	def delete_element_by_id(id)
		@database.delete_element_by_id(id)
	end

	def get_student_short_count()
		@database.get_student_short_count()
	end

end