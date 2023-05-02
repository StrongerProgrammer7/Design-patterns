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

load './student_list_DB.rb'

load './student_list.rb'

load './controller/student_list_controller.rb'
load './view/student_list_view.rb'



controller = Student_list_controller.initialize_db
application = FXApp.new
view = Student_list_view.new(application,controller)
application.create
controller.student_list_view = view
#view.show(PLACEMENT_SCREEN)
application.run