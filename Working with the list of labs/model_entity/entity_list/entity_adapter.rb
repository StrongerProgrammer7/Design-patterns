require_relative '../../model_lab/datatable/labs_list.rb'
require_relative '../../model_student/datatable/students_list.rb'

class Entity_adapter
	
	@@addressFile = "/testfile"
	@@nameFile = "test"
		
	def initialize(format_file,entity)
		case entity
  			when :student
  				@entity_list_file = Students_list.new(format_file)
  			when :lab
  				@entity_list_file = Labs_list.new(format_file)
  			else
  				raise ArgumentError, "Invalid argument #{entity}"
  		end	
	end
	
	def get_element_by_id(id)
		@entity_list_file.get_element_by_id(id)
	end

	def get_k_n_elements_list(k,n,data_list:nil)
		@entity_list_file.get_k_n_elements_list(k,n,data_list:data_list)
	end
	
	def get_elements_count()
		@entity_list_file.get_elements_count()
	end

	def push_element(element)
		@entity_list_file.push_element(element)
		@entity_list_file.write_to_file(@@addressFile,@@nameFile,@entity_list_file.list_entities)
	end

	def replace_element_by_id(id,element)
		@entity_list_file.replace_element_by_id(id,element)
		@entity_list_file.write_to_file(@@addressFile,@@nameFile,@entity_list_file.list_entities)
	end

	def delete_element_by_id(id)
		@entity_list_file.delete_element_by_id(id)
		@entity_list_file.write_to_file(@@addressFile,@@nameFile,@entity_list_file.list_entities)
	end

	
end