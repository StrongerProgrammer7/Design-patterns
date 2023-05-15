require_relative '../../model_person/list_file/persons_list_json.rb'
require_relative '../../model_person/list_file/persons_list_txt.rb'
require_relative '../../model_person/list_file/persons_list_yaml.rb'



class Entities_list
	attr_writer :format_file
	attr_reader :list_entities

	def initialize(format_file)
		self.format_file = format_file 
		self.list_entities = read_from_file(nil) #TEST: Using only json
	end

	def get_element_by_id(id)
		self.list_entities.each do |elem|
			if(Integer(elem.id) == id) then
				return elem
			end
		end
		return nil
	end

	def get_k_n_elements_list(k,n,data_list:nil)
		raise 'This method should be oveeriden and retun data_list'
	end

	def sort_by_field(data_list)
		raise 'This method should be oveeriden and retun sort elements'
	end

	def push_element(element)
		id = self.list_entities.max_by { |elem| elem.id }.id
		element.id = id.to_i + 1
		self.list_entities.push(element)
	end

	def replace_element_by_id(id,element)
		self.list_entities.map! { |elem|  elem.id == id ? element : elem }
	end

	def delete_element_by_id(id)
		self.list_entities.delete_if { |elem| elem.id == id }
	end

	def get_elements_count()
		self.list_entities.length
	end

	def write_to_file(addressFile,nameFile,elements)
		self.format_file.write_to_file(addressFile,nameFile,elements)
		self.read_from_file(nil)
	end

	private
		attr_writer :list_entities
		attr_reader :format_file

	def read_from_file(addressFile)
		self.list_entities = self.format_file.read_from_file(addressFile)
	end 

end