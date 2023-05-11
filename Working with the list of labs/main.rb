require 'fox16'

include Fox
#--------------------Student-----------
load './model_entity/entity_list/student_list.rb'

load './controller/controller.rb'
load './controller/controller_insert.rb'
load './controller/controller_update.rb'

load './view/student_list_view.rb'
load './view/modal_window_create_student.rb'
load './view/modal_window_change_student.rb'
#--------------------------------------
#-------------------Labs---------------
load './view/modal_window_labs/modal_window_create_labs.rb'
load './view/modal_window_labs/modal_window_change_labs.rb'
#--------------------------------------

mysql = Student_list.intialize_DB(:student)
mysql_lab = Student_list.intialize_DB(:lab)
json = Student_list.initialize_json(Students_list_json.new(),:student)
json_lab = Student_list.initialize_json(Labs_list_json.new(),:lab)


controller = Controller.new(mysql,mysql_lab,:hybrid)
contoller_modal_create = Controller_insert.new(controller,:hybrid)
controller_modal_change = Controller_update.new(controller,:hybrid)
application = FXApp.new

modalWindow_create = Modal_create_student.new(application,contoller_modal_create)
modalWindow_create_lab = Modal_create_lab.new(application,contoller_modal_create)
modalWindow_change = Modal_change_student.new(application,controller_modal_change)
modalWindow_change_lab = Modal_change_lab.new(application,controller_modal_change)
view = Student_list_view.new(application,controller,
	modal_create_student:modalWindow_create,
	modal_change_student:modalWindow_change,
	modal_create_lab:modalWindow_create_lab,
	modal_change_lab:modalWindow_change_lab)


controller.student_list_view = view
contoller_modal_create.student_list_view = view
controller_modal_change.student_list_view = view

view.showData(1,30)
application.create
application.run
