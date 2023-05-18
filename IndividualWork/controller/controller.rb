
require 'logger'

class Controller
	attr_writer :view
	attr_reader :entity_list

	def initialize(owners_list,guard_list,auto_list,mark_list,model_list,log_mode = :all)
		self.logger = Logger.new("log.txt")
    	case log_mode
    		when :errors
      			self.logger.level = Logger::ERROR
    		when :hybrid
      			self.logger.level = Logger::INFO
    		else
      			self.logger.level = Logger::DEBUG
    	end
    	@entity_list = owners_list
		@owners_list = owners_list
		@guard_list = guard_list
		@auto_list = auto_list
		@mark_list = mark_list
		@model_list = model_list
	end

	def change_entity(num_tab)
		case num_tab
    		when 0
      			@entity_list = @owners_list
    		when 1
      			@entity_list = @guard_list
      		when 2
      			@entity_list = @auto_list
    		else
      			@entity_list = @owners_list
    	end
		self.data_list = nil
	end

	def refresh_data(k,n,filter_initials:nil,filter_phone:nil,filter_mail:nil)
		if(self.data_list==nil) then
			self.data_list = @entity_list.get_k_n_elements_list(k,n,data_list:self.data_list,
				filter_initials:filter_initials,
				filter_phone:filter_phone,
				filter_mail:filter_mail)
		else
			@entity_list.get_k_n_elements_list(k,n,data_list:self.data_list,
				filter_initials:filter_initials,
				filter_phone:filter_phone,
				filter_mail:filter_mail)
		end
		self.data_list.observer = self.view if self.data_list.observer == nil
		self.data_list.notify(n)
		self.view.show(PLACEMENT_SCREEN)
	end

	def get_count_entities()
		@entity_list.get_elements_count()
	end

	def select_entity(num)
		self.data_list.select(num)
	end

	def deselected_entity(num)
		self.data_list.deselected(num)
	end

	def get_selected()
		self.data_list.get_selected()
	end


	def delete_entities()
		list_entites = get_selected()
		self.logger.debug("Deleting entity with ID {#{list_entites}")
		self.logger.info("Deleting entity with ID {#{list_entites}")
		list_entites.each do |id_entity|
			@entity_list.delete_element_by_id(id_entity)
			#self.view.count_records -=1
		end 
		refresh_data(self.view.num_page,self.view.count_records)
	rescue => e
		self.logger.error("Error while deleting entity :#{e}")
	end

	def get_model(id)
		@model_list.get_element_by_id(id)
	end

	def get_owner(id)
		@owners_list.get_element_by_id(id)
	end

	private 
	attr_reader :view
	attr_writer :entity_list
	attr_accessor :owners_list, :guard_list,:auto_list,:logger, :data_list

	
end