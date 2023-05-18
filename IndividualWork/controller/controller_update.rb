require_relative './controller_action.rb'

class Controller_update < Controller_action

	def initialize(parent_controller,log_mode = :all)	
		super(parent_controller,log_mode,"logger/log_update.txt")
	end
	

	def update_entity(element)
		self.logger.debug("Updating element with ID #{element["id"]} and params #{element}")
		self.logger.info("Updating element with ID #{element["id"]} and params #{element}")
		@controller.entity_list.replace_element_by_id(element["id"],element)
		@controller.refresh_data(self.view.num_page,self.view.count_records)
	rescue => e
		self.logger.error("Error while updating element with ID #{element["id"]}: #{e}")
	end

end
	