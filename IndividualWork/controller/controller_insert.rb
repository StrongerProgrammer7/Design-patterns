require_relative './controller_action.rb'

class Controller_insert < Controller_action
	def initialize(parent_controller,log_mode = :all)
		super(parent_controller,log_mode,"logger/log_create.txt")
	end
	 
	def create_entity(element)
		self.logger.debug("Creating element with params #{element}")
		self.logger.info("Creating element with params #{element}")
		@controller.entity_list.push_element(element)
		calculate_count_records()
		@controller.refresh_data(self.view.num_page,self.view.count_records)
	rescue => e
		self.logger.error("Error while creating element: #{e}")
	end

private
	def calculate_count_records()
		max_count = @controller.get_count_entities()
		if (self.view.count_records + 1 < self.view.count_records_default)
			self.view.count_records += 1 if self.view.count_records + 1 <= max_count
		else
			self.view.calculate_max_page(max_count)
		end
	end

end