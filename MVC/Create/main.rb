require 'fox16'

include Fox

load './persons/person.rb'
load './persons/student.rb'
load './persons/student_short.rb'

load './datatable/data_list_student_short.rb'

load './list_file/students_list_file.rb'
load './list_file/students_list_json.rb'
load './list_file/students_list_yaml.rb'
load './list_file/students_list_txt.rb'

load './datatable/students_list.rb'


load './controller/student_list_controller.rb'

load './controller/controller_insert.rb'
load './view/student_list_view.rb'
load './view/modal_window_create_student.rb'

mysql = Student_list.intialize_DB
json = Student_list.initialize_json(Students_list_json.new())

controller = Student_list_controller.new(mysql)
contoller_modal = Controller_insert.new(mysql)
application = FXApp.new

modalWindow = Modal_create_student.new(application,contoller_modal)
view = Student_list_view.new(application,controller,modalWindow)


controller.student_list_view = view
contoller_modal.student_list_view = view
view.showData(1,30)
application.create
application.run
