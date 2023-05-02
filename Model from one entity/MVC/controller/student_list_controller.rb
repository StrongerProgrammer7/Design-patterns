#Создать пару конструкторов в Student_list для каждого класса DB,JSON,YAML
#в  контролле просто вызывать определенный контроллер 
#Пример Student_list.get_Student_DB.new 
# в Контроллере не обязательно схранить ссылку
class Student_list_controller
	attr_writer :student_list_view
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

	
	private 
	attr_reader :student_list_view

end