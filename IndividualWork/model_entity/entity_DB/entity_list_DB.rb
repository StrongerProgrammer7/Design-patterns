require_relative '../Database/database.rb'
require_relative File.dirname($0) + '/../../model_person/datatable/data_list_person_short.rb'
require_relative File.dirname($0) + '/../../model_person/persons/person_short.rb'

class Entities_list_DB

	def initialize()
		@dbcon = Parking_DB.getInstance()
	end 
	
	def get_element_by_id(id)
		raise 'This method should be oveeriden and retun element'
	end

	def get_k_n_elements_list(k,n,data_list:nil)
		raise 'This method should be oveeriden and retun data_list_elements'
	end

	def push_element(element)
		raise 'This method should be oveeriden'
	end

	def replace_element_by_id(id,element)
		raise 'This method should be oveeriden'
	end

	def delete_element_by_id(id)
		raise 'This method should be oveeriden'
	end

	def get_elements_count()
		raise 'This method should be oveeriden'
	end
	
	private 
		@dbcon = nil
end