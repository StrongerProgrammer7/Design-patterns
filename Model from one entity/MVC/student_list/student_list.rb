require_relative File.dirname($0) + './student_DB/student_list_DB.rb'
require_relative File.dirname($0) + '/student_adapter.rb'

class Student_list
	attr_writer :strategy
	
	#def initialize(strategy)
	#	self.strategy = strategy
	#end
	
	def self.intialize_txt(txt)
		self.strategy = Student_Adapter.new(txt)
	end

	def self.initialize_json(json)
		self.strategy = Student_Adapter.new(json)
	end
	
	def self.initialize_yaml(yaml)
		self.strategy = Student_Adapter.new(yaml)
	end

	def self.intialize_DB()
		self.strategy = Students_list_DB.new
	end
	
	def get_student_by_id(id)
		self.strategy.get_student_by_id(id)
	end

	def get_k_n_student_short_list(k,n,data_list:nil)
		self.strategy.get_k_n_student_short_list(k,n,data_list)
	end

	def push_student(student)
		self.strategy.push_student(student)
	end

	def replace_element_by_id(id,element)
		self.strategy.replace_element_by_id(id,element)
	end

	def delete_element_by_id(id)
		self.strategy.delete_element_by_id(id)
	end

	def get_student_short_count()
		self.strategy.get_student_short_count()
	end
	private 
		attr_reader :strategy
end