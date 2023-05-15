require 'fox16'

include Fox
#--------------------Entity-----------
load './model_entity/entity_list/Parking_list.rb'
load './model_person/list_file/owner_list.rb'
load './model_person/list_file/guard_list.rb'

load './controller/controller.rb'
load './controller/controller_insert.rb'
load './controller/controller_update.rb'

load './views/view.rb'
load './views/modal_window_owners/modal_window_create_student.rb'
load './views/modal_window_owners/modal_window_change_student.rb'
#--------------------------------------
#-------------------Labs---------------
load './views/modal_window_labs/modal_window_create_labs.rb'
load './views/modal_window_labs/modal_window_change_labs.rb'
#--------------------------------------

class Factory
	def self.actions(type_action,enitity,files:nil)
  	case type_action
  	when :mysql
  		Parking_list.intialize_DB(enitity)
  	when :json
  		Parking_list.initialize_json(files,enitity)
  	when :yaml
  		Parking_list.initialize_yaml(files,enitity)
  	when :txt
  		Parking_list.initialize_txt(files,enitity)
  	else
  		raise ArgumentError, "Invalid argument #{type_action}"
  	end
  end
  
  def self.build_main_controller(entity_1,entity_2,entity_3)
	Controller.new(entity_1,entity_2,entity_3,:hybrid)
  end
  
  def self.build_main_window(application,
		modal_create_ent1:nil,
		modal_change_ent1:nil,
		modal_create_ent2:nil,
		modal_change_ent2:nil)
	 Parking_view.new(application,
	   modal_create_owner:modal_create_ent1,
	   modal_change_owner:modal_change_ent1,
	   modal_create_guard:modal_create_ent2,
	   modal_change_guard:modal_change_ent2)
  end

  def self.build_controllers(controller_type,main_controller)
  	case controller_type
  	when :insert
  		Controller_insert.new(main_controller,:hybrid)
  	when :update
  		Controller_update.new(main_controller,:hybrid)
  	else
  		raise ArgumentError, "Invalid argument #{controller_type}"
  	end
  end
  
  def self.build_modals(application,window_type)
    case window_type
    when :add_student
     	Modal_create_student.new(application)
    when :change_student
     	Modal_change_student.new(application)
	when :add_lab
     	Modal_create_lab.new(application)
    when :change_lab
     	Modal_change_lab.new(application)
    else
      raise ArgumentError, "Invalid window type: #{window_type}"
    end
  end

  def self.connection_controller_window(controller,window)
  	controller.view = window
  end

  def self.connection_window_controller(controller,window)
  	window.controller = controller
  end
end

mysql_owner = Factory.actions(:mysql,:owner)
mysql_guard = Factory.actions(:mysql,:guard)
mysql_auto = Factory.actions(:mysql,:auto)
json_owner = Factory.actions(:json,:owner,files:Persons_list_json.new(person:Owner_list.new(:json)))
json_guard = Factory.actions(:json,:guard,files:Persons_list_json.new(person:Guard_list.new(:json))) 


controller = Factory.build_main_controller(mysql_owner,mysql_guard,mysql_auto)
contoller_modal_create = Factory.build_controllers(:insert,controller)
controller_modal_change = Factory.build_controllers(:update,controller)
application = FXApp.new

#modalWindow_create = Factory.build_modals(application,:add_student)
#modalWindow_create_lab = Factory.build_modals(application,:add_lab)
#modalWindow_change = Factory.build_modals(application,:change_student)
#modalWindow_change_lab = Factory.build_modals(application,:change_lab)
#Factory.connection_window_controller(contoller_modal_create,modalWindow_create)
#Factory.connection_window_controller(contoller_modal_create,modalWindow_create_lab)
#Factory.connection_window_controller(controller_modal_change,modalWindow_change)
#Factory.connection_window_controller(controller_modal_change,modalWindow_change_lab)

view = Factory.build_main_window(application,
  modal_create_ent1:nil,
  modal_change_ent1:nil,
  modal_create_ent2:nil,
  modal_change_ent2:nil)

Factory.connection_controller_window(controller,view)
Factory.connection_controller_window(contoller_modal_create,view)
Factory.connection_controller_window(controller_modal_change,view)
Factory.connection_window_controller(controller,view)

#view.showData(1,30)
view.show(PLACEMENT_SCREEN)
application.create
application.run
