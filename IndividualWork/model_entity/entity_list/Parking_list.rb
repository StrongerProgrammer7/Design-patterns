require_relative '../../model_person/person_DB/owners_list_DB.rb'
require_relative '../../model_person/person_DB/guards_list_DB.rb'
require_relative '../../model_auto/auto_DB/auto_list_DB.rb'
require_relative '../../model_auto/auto_DB/mark_list_DB.rb'

require_relative File.dirname($0) + '/entity_adapter.rb'

class Parking_list
	attr_writer :strategy
	
	def self.intialize_txt(txt,entity)
  		Parking_list.new(Entity_adapter.new(txt,entity))
	end

	def self.initialize_json(json,entity)
		Parking_list.new(Entity_adapter.new(json,entity))	
	end
	
	def self.initialize_yaml(yaml,entity)
		Parking_list.new(Entity_adapter.new(yaml,entity))	
	end

	def self.intialize_DB(entity)
		case entity
  			when :owner
  				Parking_list.new(Owners_list_DB.new())
  			when :guard
  				Parking_list.new(Guards_list_DB.new())
			when :auto
  				Parking_list.new(Auto_list_DB.new())
  			when :mark
  				Parking_list.new(Mark_list_DB.new())
  			else
  				raise ArgumentError, "Invalid argument #{entity}"
  		end		
	end
	
	def get_element_by_id(id)
		@strategy.get_element_by_id(id)
	end

	def get_k_n_elements_list(k,n,data_list:nil,filter_initials:nil,filter_phone:nil,filter_mail:nil)
		@strategy.get_k_n_elements_list(k,n,data_list:data_list,
			filter_initials:filter_initials,
			filter_phone:filter_phone,
			filter_mail:filter_mail)
	end

	def push_element(element)
		@strategy.push_element(element)
	end

	def replace_element_by_id(id,element)
		@strategy.replace_element_by_id(id,element)
	end

	def delete_element_by_id(id)
		@strategy.delete_element_by_id(id)
	end

	def get_elements_count()
		@strategy.get_elements_count()
	end
	private 
		attr_reader :strategy

	def initialize(strategy)
		self.strategy = strategy
	end
end