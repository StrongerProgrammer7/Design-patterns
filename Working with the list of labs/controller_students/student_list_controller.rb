
require 'logger'

class Student_list_controller
	attr_writer :student_list_view
	attr_reader :data_list_student_short, :logger,:student_list

	def initialize(student_list,log_mode = :all)
		@student_list = student_list
		self.logger = Logger.new("log.txt")
    	case log_mode
    		when :errors
      			self.logger.level = Logger::ERROR
    		when :hybrid
      			self.logger.level = Logger::INFO
    		else
      			self.logger.level = Logger::DEBUG
    	end
	end


	def refresh_data(k,n)
		if(self.data_list_student_short==nil) then
			self.data_list_student_short = @student_list.get_k_n_elements_list(k,n,data_list:self.data_list_student_short)
		else
			@student_list.get_k_n_elements_list(k,n,data_list:self.data_list_student_short)
		end
		self.data_list_student_short.student_list_view = self.student_list_view if self.data_list_student_short.student_list_view == nil
		self.data_list_student_short.notify(n)
		self.student_list_view.show(PLACEMENT_SCREEN)
	end

	def get_count_student_short()
		@student_list.get_elements_count()
	end

	def select_student(num)
		self.data_list_student_short.select(num)
	end

	def deselected_student(num)
		self.data_list_student_short.deselected(num)
	end

	def get_selected()
		self.data_list_student_short.get_selected()
	end

	

	def delete_student()
		list_student = get_selected()
		self.logger.debug("Deleting student with ID {#{list_student}")
		self.logger.info("Deleting student with ID {#{list_student}")
		list_student.each do |id_student|
			@student_list.delete_element_by_id(id_student)
		end 
		refresh_data(self.student_list_view.num_page,self.student_list_view.count_records)
	rescue => e
		self.logger.error("Error while deleting student :#{e}")
	end

	private 
	attr_reader :student_list_view
	attr_writer :data_list_student_short, :logger, :student_list

	
end