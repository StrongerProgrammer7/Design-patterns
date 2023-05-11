
require 'logger'

class Controller
	attr_writer :student_list_view
	attr_reader :entity_list

	def initialize(student_list,lab_list,log_mode = :all)
		self.logger = Logger.new("log.txt")
    	case log_mode
    		when :errors
      			self.logger.level = Logger::ERROR
    		when :hybrid
      			self.logger.level = Logger::INFO
    		else
      			self.logger.level = Logger::DEBUG
    	end
    	@entity_list = student_list
		@student_list = student_list
		@lab_list = lab_list
	end

	def change_entity()
		@entity_list = (self.student_list_view.current_table.to_s.include? "Table_lab_works")? @lab_list : @student_list
		n = @entity_list == @student_list ? 30 : 16
		self.data_list = @entity_list.get_k_n_elements_list(1,n,data_list:nil)
	end

	def refresh_data(k,n)
		if(self.data_list==nil) then
			self.data_list = @entity_list.get_k_n_elements_list(k,n,data_list:self.data_list)
		else
			@entity_list.get_k_n_elements_list(k,n,data_list:self.data_list)
		end
		self.data_list.student_list_view = self.student_list_view if self.data_list.student_list_view == nil
		self.data_list.notify(n)
		self.student_list_view.show(PLACEMENT_SCREEN)
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
		end 
		refresh_data(self.student_list_view.num_page,self.student_list_view.count_records)
	rescue => e
		self.logger.error("Error while deleting entity :#{e}")
	end

	private 
	attr_reader :student_list_view
	attr_writer :data_list, :logger, :entity_list
	attr_accessor :student_list, :lab_list,:logger, :data_list

	
end