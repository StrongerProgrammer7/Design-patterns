require_relative File.dirname($0) + './student_DB/student_list_DB.rb'
require_relative File.dirname($0) + '/student_adapter.rb'

class Student_list
	attr_writer :strategy
	
	def initialize(strategy)
		self.strategy = strategy
	end
	def get_student_by_id(id)
		strategy.get_student_by_id(id)
	end

	def get_k_n_student_short_list(k,n,data_list:nil)
		strategy.get_k_n_student_short_list(k,n,data_list)
	end

	def push_student(student)
		strategy.push_student(student)
	end

	def replace_element_by_id(id,element)
		strategy.replace_element_by_id(id,element)
	end

	def delete_element_by_id(id)
		strategy.delete_element_by_id(id)
	end

	def get_student_short_count()
		strategy.get_student_short_count()
	end
	private 
		attr_reader :strategy
end