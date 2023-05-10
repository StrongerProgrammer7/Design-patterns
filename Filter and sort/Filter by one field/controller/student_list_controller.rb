
require 'logger'

class Student_list_controller
	attr_writer :student_list_view
	attr_reader :data_list_student_short, :logger

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

	def refresh_data(k,n,filter_git:nil)
		refresh_data_list_student_short(k,n,filter_git:filter_git)
		self.data_list_student_short.student_list_view = self.student_list_view if self.data_list_student_short.student_list_view == nil
		self.data_list_student_short.notify(n)
		self.student_list_view.show(PLACEMENT_SCREEN)
	rescue => e
		self.logger.error("Error while get student :#{e}")
	end

	#def refresh_data_by_git(k,n,filter_git)
	#	refresh_data_list_student_short(k,n,filter_git:filter_git)
	#	refresh_data(k,n)
	#end

	def get_count_student_short()
		@student_list.get_student_short_count
	end

	def select_student(num)
		self.data_list_student_short.select(num)
	end

	def get_selected()
		self.data_list_student_short.get_selected()
	end

	def get_student_by_id(id)
		@student_list.get_student_by_id(id)
	end

	def delete_student()
		list_student = get_selected()
		self.logger.debug("Deleting student with ID {#{list_student}")
		self.logger.info("Deleting student with ID {#{list_student}")
		list_student.each do |id_student|
			@student_list.delete_element_by_id(id_student)
		end 
	rescue => e
		self.logger.error("Error while deleting student :#{e}")
	end

	private 
	attr_reader :student_list_view
	attr_writer :data_list_student_short, :logger

	def refresh_data_list_student_short(k,n,filter_git:nil)
		if(self.data_list_student_short==nil) then
			self.data_list_student_short = @student_list.get_k_n_student_short_list(k,n,data_list:self.data_list_student_short, filter_git: filter_git)
		else
			@student_list.get_k_n_student_short_list(k,n,data_list:self.data_list_student_short,filter_git: filter_git)
		end
	end

	
end