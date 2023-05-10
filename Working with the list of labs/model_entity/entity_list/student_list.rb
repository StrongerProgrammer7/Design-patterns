require_relative '../../model_student/student_DB/student_list_DB.rb'
require_relative '../../model_lab/lab_DB/labs_list_DB.rb'
require_relative File.dirname($0) + '/entity_adapter.rb'

class Student_list
	attr_writer :strategy
	
	def self.intialize_txt(txt,entity)
  		Student_list.new(Entity_adapter.new(txt,entity))
	end

	def self.initialize_json(json,entity)
		Student_list.new(Entity_adapter.new(json,entity))	
	end
	
	def self.initialize_yaml(yaml,entity)
		Student_list.new(Entity_adapter.new(yaml,entity))	
	end

	def self.intialize_DB(entity)
		case entity
  			when :student
  				Student_list.new(Students_list_DB.new())
  			when :lab
  				Student_list.new(Labs_list_DB.new())
  			else
  				raise ArgumentError, "Invalid argument #{entity}"
  		end		
	end
	
	def get_student_by_id(id)
		@strategy.get_element_by_id(id)
	end

	def get_k_n_student_short_list(k,n,data_list:nil)
		@strategy.get_k_n_elements_list(k,n,data_list:data_list)
	end

	def push_student(student)
		@strategy.push_element(student)
	end

	def replace_element_by_id(id,element)
		@strategy.replace_element_by_id(id,element)
	end

	def delete_element_by_id(id)
		@strategy.delete_element_by_id(id)
	end

	def get_student_short_count()
		@strategy.get_elements_count()
	end
	private 
		attr_reader :strategy

	def initialize(strategy)
		self.strategy = strategy
	end
end