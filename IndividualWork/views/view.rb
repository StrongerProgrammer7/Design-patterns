require_relative File.dirname($0) + './views/button_control_view.rb'
require_relative File.dirname($0) + './views/filter_control_view.rb'
require_relative File.dirname($0) + './views/tables/table__persons.rb'
require_relative File.dirname($0) + './views/tables/table_labs.rb'

require 'fox16'

include Fox

class Parking_view < FXMainWindow

	attr_reader :num_page, :current_table,:count_records_default
	attr_writer :controller
	attr_accessor :count_records
  def initialize(app,modal_create_owner:nil,
  					modal_change_owner:nil,
  					modal_create_guard:nil,
  					modal_change_guard:nil,
					modal_create_auto:nil,
					modal_change_auto:nil)
  	
  	self.modal_window_create_owner = modal_create_owner
  	self.modal_window_change_owner = modal_change_owner
  	self.modal_window_create_guard = modal_create_guard
  	self.modal_window_change_guard = modal_change_guard
    super(app, "Parking list", :width => 1000, :height => 600)
	
    horizontal_frame = FXHorizontalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
	
    tab_book = FXTabBook.new(horizontal_frame)


	createTab(tab_book,"Owner ")
	@table_owner = fillTab_persons(tab_book,"Owner table",
		modal_create:self.modal_window_create_owner,
		modal_update:self.modal_window_change_owner)
	self.current_table = @table_owner

    createTab(tab_book,"Guard")
    @table_guard = fillTab_persons(tab_book,"Guard table",
    	modal_create:self.modal_window_create_guard,
    	modal_update:self.modal_window_change_guard)


    createTab(tab_book, "Auto")
    createLabelByCenter(tab_book)

    tab_book.connect(SEL_COMMAND) do |sender, sel, data|
    	if data == 0 then
    		self.current_table = @table_owner
    		@controller.change_entity(0)
    		self.count_records = self.count_records_default
    	elsif data == 1 then
    		self.current_table = @table_guard
    		@controller.change_entity(1)
    		self.count_records = self.count_records_default
    	else
    		self.current_table = @table_owner		
    	end
    	 	@selected_items = []
    	 	@controller.refresh_data(1,self.count_records)
    end

   
    close_button = FXButton.new(horizontal_frame, "Close", nil, nil, 0, LAYOUT_FILL_X)
    close_button.connect(SEL_COMMAND) { getApp().exit }

    horizontal_frame.layoutHints |= LAYOUT_BOTTOM|LAYOUT_LEFT|LAYOUT_RIGHT|LAYOUT_FILL_X
    tab_book.layoutHints |= LAYOUT_FILL_X|LAYOUT_FILL_Y
    close_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
		
  end
  
  	def showData(k,n)
  		self.num_page = k
  		self.count_records_default = n
  		max_count_entities = @controller.get_count_entities()
  		calculate_max_page(max_count_entities)
  		n = max_count_entities if max_count_entities < n
  		self.count_records = n
  		@controller.refresh_data(k,n)
  	end

  	def set_table_params(column_names,whole_entites_count)
		self.current_table.set_table_params(column_names,whole_entites_count)
		self.current_table.create_button_change_page()
		initializeButtonTable_getData(self.current_table)
	end
	
	def set_table_data(data_table)
		self.current_table.set_table_data(data_table) if data_table!=[] and data_table!=nil
	end

	def calculate_max_page(max_count_entities)
  		self.max_page_data = (max_count_entities / self.count_records_default) + 1
	end

  private 
	attr_accessor :max_page_data, :modal_window_create_owner, :modal_window_change_owner,:modal_window_create_guard, :modal_window_change_guard
	attr_writer :num_page, :current_table,:count_records_default
	attr_reader :controller
	
	def createTab(tab_book, name_tab)
    	FXTabItem.new(tab_book, name_tab)
	end

	def createLabelByCenter(tab_book)
    	label = FXLabel.new(tab_book, "This is new tab")
    	label.justify = JUSTIFY_CENTER_X|JUSTIFY_CENTER_Y
	end

	def fillTab_persons(tab_book,name_table,modal_create:nil,modal_update:nil)
		tab_frame = FXHorizontalFrame.new(tab_book,LAYOUT_FILL_X|LAYOUT_FILL_Y)
	
		list_filters = initialize_filter(tab_frame)

		table = Table_persons.new(tab_frame,name_table)
		

		list_btn = initialize_control(tab_frame)

		events_entities_controls(table,list_btn[0],list_btn[1],list_btn[2],list_btn[3],modal_add:modal_create,modal_change:modal_update)
		event_filters(list_filters[0],list_filters[1])
		table
	end


	def fillTab_labs(tab_book)
		tab_frame = FXHorizontalFrame.new(tab_book,LAYOUT_FILL_X|LAYOUT_FILL_Y)
		
		@table_labs = Table_lab_works.new(tab_frame,"Labs table")
	
		list_btn = initialize_control(tab_frame)
		events_entities_controls(@table_labs,
			list_btn[0],list_btn[1],list_btn[2],list_btn[3],
			modal_add:self.modal_window_create_guard,
			modal_change:self.modal_window_change_guard)
		
		list_btn[3].connect(SEL_COMMAND) do |sender,sel,data|	
			clearSelect()
			disable_button_edit_delete(list_btn[1],list_btn[2])
			@controller.refresh_data(1,self.count_records)
		end
	end

	def initialize_filter(tab_frame)
		filters = Filter.new 
		filter_area = filters.create_filter_area(tab_frame,180)
		filter_surname = filters.add_filter_input(filter_area,"Surname N.L.: ")
		filter_phone = filters.add_filter_input(filter_area,"Phone")
		filter_mail = filters.add_filter_radioBtn(filter_area,@filter_mail,"Наличие почты")
		update_btn = filters.add_controlBtn(filter_area)	
		return [filter_surname,filter_phone,filter_mail,filter_mail,update_btn]	
	end

	
	def initializeButtonTable_getData(table)
		table.next_data_button.connect(SEL_COMMAND) do |sender,sel,data|
				if(self.num_page < self.max_page_data) then
					self.num_page+=1
					table.label_num_current_page_data.text = "#{self.num_page} page of #{self.max_page_data} data"
    	 		showData(self.num_page,self.count_records)
    	 		@selected_items=[]
    	 	end 
    	end

    	table.prev_data_button.connect(SEL_COMMAND) do |sender,sel,data|
    		if(self.num_page > 1) then
    			self.num_page-=1
    			table.label_num_current_page_data.text = "#{self.num_page} page of #{self.max_page_data} data" 
    	 		showData(self.num_page,self.count_records) 
    	 		@selected_items=[]
    	 	end
    	end
	end

	def initialize_control(tab_frame)
		button_control = Button_control.new(tab_frame)
		add = button_control.createButton("Add")
		ed = button_control.createButton("Edit")
		del = button_control.createButton("Delete")
		update = button_control.createButton("update")
		return [add,ed,del,update]
	end

	def events_entities_controls(table,add,ed,del,update,modal_add:nil,modal_change:nil)
		disable_button_edit_delete(ed,del)

		event_table_selected(table,ed,del)
		event_table_deselected(table,ed,del)	
		
		event_addEntity(modal_add,add)
		event_delete_entity(ed,del)
		event_change_entity(modal_change,ed,del)
	end

	def event_filters(filter_initials,filter_phone)
		
		event_filters_verify(filter_initials:filter_initials,filter_phone:filter_phone)

		filter_initials.connect(SEL_CHANGED) do
			raise "Table is empty" if self.current_table.table.numRows == 0
				if filter_initials.text!=nil and filter_initials.text != "" then
					if filter_initials.text.match(/^[A-zА-яЁё\s\.]+$/) then
						self.current_table.filter_data(filter_surname_initials:filter_initials.text)
					end				
				else
					self.current_table.filter_data()
				end	 
		end
	
		filter_phone.connect(SEL_CHANGED) do
			raise "Table is empty" if self.current_table.table.numRows == 0
				if filter_phone.text!=nil and filter_phone.text != "" then
					if /^\+?[0-9]*$/.match(filter_phone.text)!=nil then
						self.current_table.filter_data(filter_phone:filter_phone.text)
					end				
				else
					self.current_table.filter_data()
				end	
		end
	end


	def event_filters_verify(filter_initials:nil,filter_phone:nil)
		filter_initials.connect(SEL_VERIFY) do |sender, sel, tentative|
    		if tentative.match(/^[A-zА-яЁё\.]*$/)
    			false 
    		else		
    			true
    		end
    	end

    	filter_phone.connect(SEL_VERIFY) do |sender, sel, tentative|
    		if /^\+?[0-9]*$/.match(tentative)
    			false 
    		else		
    			true
    		end
    	end
	end


	def disable_button_edit_delete(ed,del)
		ed.disable
		del.disable
	end


	def event_table_selected(current_table,ed_btn,del_btn)
		@selected_items = []
		current_table.table.connect(SEL_SELECTED) do |sender, selector, data|
			
			item = sender.getItem(data.row, 0) #data.col
			@selected_items << data.row.to_s unless @selected_items.include? data.row.to_s if item != '' and item != nil

			if @selected_items.length > 1 then
				ed_btn.disable
				del_btn.enable
			elsif @selected_items.length == 1 then
				ed_btn.enable
				del_btn.enable
			else
				disable_button_edit_delete(ed_btn,del_btn)
			end
			self.controller.select_entity(data.row.to_s) if item != '' and item != nil
		end
	end

	def event_table_deselected(current_table,ed_btn,del_btn)
		current_table.table.connect(SEL_DESELECTED) do |sender, sel, pos|
			@selected_items.delete(pos.row.to_s) #pos.row pos.col
			self.controller.deselected_entity(pos.row.to_s)
			if @selected_items.length == 0 then
				disable_button_edit_delete(ed_btn,del_btn)
			end
		end
	end

	def clearSelect()
		@selected_items.each do |elem| 
			self.controller.deselected_entity(elem.to_s)
		end
		@selected_items = []
	end

	def event_addEntity(modal_window_add,add_btn)
		add_btn.connect(SEL_COMMAND) do |sender,sel,data|	
			modal_window_add.show(PLACEMENT_SCREEN)
			modal_window_add.addTimeoutCheck(data:self.current_table.data)
    	end
	end

	def event_change_entity(modal_window_change,ed_btn,del_btn)
		ed_btn.connect(SEL_COMMAND) do |sender,sel,data|	
			modal_window_change.show(PLACEMENT_SCREEN)	
			id = self.controller.get_selected()[0]
			modal_window_change.get_personal_data(id)
			modal_window_change.addTimeoutCheck(data:self.current_table.data)
			clearSelect()
			disable_button_edit_delete(ed_btn,del_btn)
    	end
	end

	def event_delete_entity(ed,del_btn)
		del_btn.connect(SEL_COMMAND) do |sender,sel,data|
    		self.controller.delete_entities()
    		clearSelect()
    		disable_button_edit_delete(ed,del_btn)
    	end
	end

	def disable_button_edit_delete(ed,del)
		if @selected_items != nil && @selected_items.length <= 0 then
			ed.disable
			del.disable
		end
	end
end

