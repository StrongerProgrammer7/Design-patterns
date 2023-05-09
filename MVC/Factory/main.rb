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

load './student_list/student_list.rb'

load './controller/student_list_controller.rb'

load './controller/controller_insert.rb'
load './controller/controller_update_surname.rb'
load './view/student_list_view.rb'
load './view/modal_window_create_student.rb'
load './view/modal_window_change_student.rb'

class Factory
	def self.actions(type_action)
  	case type_action
  	when :mysql
  		@@type_action = Student_list.intialize_DB
  	when :json
  		@@type_action = Student_list.initialize_json(Students_list_json.new())
  	when :yaml
  		@@type_action = Student_list.initialize_yaml(Students_list_yaml.new())
  	when :txt
  		@@type_action = Student_list.initialize_txt(Students_list_txt.new())
  	else
  		raise ArgumentError, "Invalid argument #{type_action}"
  	end
  end

  def self.build_controller(controller_type)
  	case controller_type
  	when :main
  		Student_list_controller.new(@@type_action)
  	when :insert
  		Controller_insert.new(@@type_action)
  	when :update_surname
  		Controller_update_surname.new(@@type_action)
  	else
  		raise ArgumentError, "Invalid argument #{controller_type}"
  	end
  end
  
  def self.build_window(application,window_type)
    case window_type
    when :main
  		Student_list_view.new(application)
    when :add_student
     	Modal_create_student.new(application)
    when :change_student
     	Modal_change_student.new(application)
    else
      raise ArgumentError, "Invalid window type: #{window_type}"
    end
  end

  def self.connection_controller_window(controller,window)
  	controller.student_list_view = window
  end

  def self.connection_window_controller(controller,window)
  	window.student_list_controller = controller
  end
end

#mysql = Student_list.intialize_DB
#json = Student_list.initialize_json(Students_list_json.new())

application = FXApp.new

Factory.actions(:mysql)
#ControlerFactory.actions(:json)
controller_insert = Factory.build_controller(:insert)
controller_update_surname = Factory.build_controller(:update_surname)
controller = Factory.build_controller(:main)

modal_view_create = Factory.build_window(application,:add_student)
modal_view_change = Factory.build_window(application,:change_student)
main = Factory.build_window(application,:main)
Factory.connection_window_controller(controller_insert,modal_view_create)
Factory.connection_window_controller(controller_update_surname,modal_view_change)
Factory.connection_window_controller(controller,main)

Factory.connection_controller_window(controller_insert,main)
Factory.connection_controller_window(controller_update_surname,main)
Factory.connection_controller_window(controller,main)

main.modal_window_create_student = modal_view_create
main.modal_window_change_student = modal_view_change

main.showData(1,30)
application.create
application.run
