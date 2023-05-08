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
load './controller/controller_update_surname.rb'
load './view/student_list_view.rb'
load './view/modal_window_create_student.rb'
load './view/modal_window_change_student.rb'


mysql = Student_list.intialize_DB
json = Student_list.initialize_json(Students_list_json.new())

controller = Student_list_controller.new(mysql,:hybrid)
contoller_modal_create = Controller_insert.new(mysql,:hybrid)
controller_modal_change = Controller_update_surname.new(mysql,:hybrid)
application = FXApp.new

modalWindow_create = Modal_create_student.new(application,contoller_modal_create)
modalWindow_change = Modal_change_student.new(application,controller_modal_change)
view = Student_list_view.new(application,controller,modal_create:modalWindow_create,modal_change:modalWindow_change)


controller.student_list_view = view
contoller_modal_create.student_list_view = view
controller_modal_change.student_list_view = view

view.showData(1,30)
application.create
application.run
