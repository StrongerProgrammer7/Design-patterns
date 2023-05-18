require 'fox16'

include Fox
#--------------------Entity-----------
load './model_entity/entity_list/Parking_list.rb'
load './model_person/list_file/owner_list.rb'
load './model_person/list_file/guard_list.rb'
load './model_auto/datatable/auto_list.rb'
load './model_auto/datatable/mark_list.rb'
load './model_auto/datatable/model_list.rb'
#--------------------Controller-----------
load './controller/controller.rb'
load './controller/controller_insert.rb'
load './controller/controller_update.rb'

load './views/view.rb'
#------------------Owner---------------
load './views/modal_window_owners/modal_window_create_owner.rb'
load './views/modal_window_owners/modal_window_change_owner.rb'
#--------------------------------------
#------------------Guard---------------
load './views/modal_window_guards/modal_window_create_guard.rb'
load './views/modal_window_guards/modal_window_change_guard.rb'
#--------------------------------------
#-------------------Auto---------------
#load './views/modal_window_labs/modal_window_create_labs.rb'
#load './views/modal_window_labs/modal_window_change_labs.rb'
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
  
  def self.build_main_controller(owner:nil,guard:nil,auto:nil)
	   Controller.new(owner,guard,auto,:hybrid)
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
    when :add_owner
     	Modal_create_owner.new(application)
    when :change_owner
     	Modal_change_owner.new(application)
	  when :add_guard
     	Modal_create_guard.new(application)
    when :change_guard
     	Modal_change_guard.new(application)
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


controller = Factory.build_main_controller(owner:mysql_owner,guard:mysql_guard,auto:mysql_auto)
contoller_modal_create = Factory.build_controllers(:insert,controller)
controller_modal_change = Factory.build_controllers(:update,controller)
application = FXApp.new

modalWindow_create_owner = Factory.build_modals(application,:add_owner)
modalWindow_create_guard = Factory.build_modals(application,:add_guard)
modalWindow_change_owner = Factory.build_modals(application,:change_owner)
modalWindow_change_guard = Factory.build_modals(application,:change_guard)
Factory.connection_window_controller(contoller_modal_create,modalWindow_create_owner)
Factory.connection_window_controller(contoller_modal_create,modalWindow_create_guard)
Factory.connection_window_controller(controller_modal_change,modalWindow_change_owner)
Factory.connection_window_controller(controller_modal_change,modalWindow_change_guard)

view = Factory.build_main_window(application,
  modal_create_ent1:modalWindow_create_owner,
  modal_change_ent1:modalWindow_change_owner,
  modal_create_ent2:modalWindow_create_guard,
  modal_change_ent2:modalWindow_change_guard)

Factory.connection_controller_window(controller,view)
Factory.connection_controller_window(contoller_modal_create,view)
Factory.connection_controller_window(controller_modal_change,view)
Factory.connection_window_controller(controller,view)

view.showData(1,8)
application.create
application.run
