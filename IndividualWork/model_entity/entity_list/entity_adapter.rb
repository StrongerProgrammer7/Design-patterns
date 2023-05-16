#require_relative '../../model_lab/datatable/labs_list.rb'
require_relative '../../model_person/datatable/owners_list.rb'
require_relative '../../model_person/datatable/guards_list.rb'
require_relative '../../model_auto/datatable/auto_list.rb'

class Entity_adapter
	
	#-------------DEV----------------
	attr_accessor :addressFile, :nameFile
	#--------------------------------
		
	def initialize(format_file,entity)
		self.nameFile = "test"
		case entity
  			when :owner
  				self.addressFile = "/../../testfile/testfile_owners/"
  				@entity_list_file = Owners_list.new(format_file)
  			when :guard
  				self.addressFile ="/../../testfile/testfile_guards/"
  				@entity_list_file = Guards_list.new(format_file)
			when :auto
  				self.addressFile ="/../../testfile/testfile_auto/"
  				@entity_list_file = Auto_list.new(format_file)
  			else
  				raise ArgumentError, "Invalid argument #{entity}"
  		end	
	end
	
	def get_element_by_id(id)
		@entity_list_file.get_element_by_id(id)
	end

	def get_k_n_elements_list(k,n,data_list:nil,filter_initials:nil,filter_phone:nil,filter_mail:nil)
		@entity_list_file.get_k_n_elements_list(k,n,data_list:data_list,
			filter_initials:filter_initials,
			filter_phone:filter_phone,
			filter_mail:filter_mail)
	end
	
	def get_elements_count()
		@entity_list_file.get_elements_count()
	end

	def push_element(element)
		@entity_list_file.push_element(element)
		@entity_list_file.write_to_file(self.addressFile,self.nameFile,@entity_list_file.list_entities)
	end

	def replace_element_by_id(id,element)
		@entity_list_file.replace_element_by_id(id,element)
		@entity_list_file.write_to_file(self.addressFile,self.nameFile,@entity_list_file.list_entities)
	end

	def delete_element_by_id(id)
		@entity_list_file.delete_element_by_id(id)
		@entity_list_file.write_to_file(self.addressFile,self.nameFile,@entity_list_file.list_entities)
	end

	
end