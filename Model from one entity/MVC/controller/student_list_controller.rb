#Создать пару конструкторов в Student_list для каждого класса DB,JSON,YAML
#в  контролле просто вызывать определенный контроллер 
#Пример Student_list.get_Student_DB.new 
# в Контроллере не обязательно схранить ссылку
require_relative File.dirname($0) + './view/student_list_view.rb'
require_relative File.dirname($0) + './student_list/student_list.rb'
require_relative File.dirname($0) + './datatable/data_list_student_short.rb'

class Student_list_controller
	attr_writer :student_list_view
	attr_reader :data_list_student_short

	def initialize_txt(txt)
		@student_list = Student_list.intialize_txt(txt)
	end

	def initialize_json(json)
		@student_list = Student_list.initialize_json(json)
	end

	def initialize_yaml(yaml)
		@student_list = Student_list.initialize_yaml(yaml)
	end

	def initialize_db()
		@student_list = Student_list.intialize_DB
	end

	def refresh_data(k,n,data_list:nil)
		self.data_list_student_short = @student_list.get_k_n_student_short_list(k,n,data_list)
		self.data_list_student_short.student_list_view = self.student_list_view
		self.data_list_student_short.notify()
		self.student_list_view.show(PLACEMENT_SCREEN)
	end

	private 
	attr_reader :student_list_view
	attr_writer :data_list_student_short

end