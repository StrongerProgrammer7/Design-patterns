require_relative './controller_action.rb'

class Controller_insert < Controller_action
	def initialize(parent_controller,log_mode = :all)
		super(parent_controller,log_mode,"logger/log_create.txt")
	end
	 
	def create_entity(element)
		self.logger.debug("Creating element with params #{element}")
		self.logger.info("Creating element with params #{element}")
		@controller.entity_list.push_element(element)
		@controller.refresh_data(self.view.num_page,self.view.count_records)
	rescue => e
		self.logger.error("Error while creating student: #{e}")
	end

end