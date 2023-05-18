require_relative File.dirname($0) + './views/button_control_view.rb'
require_relative File.dirname($0) + './views/filter_control_view.rb'
require_relative File.dirname($0) + './views/tables/table__persons.rb'
require_relative File.dirname($0) + './views/tables/table_auto.rb'

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
    @table_auto = fillTab_auto(tab_book,"Auto table",
    	modal_create:nil,
    	modal_update:nil)

    tab_book.connect(SEL_COMMAND) do |sender, sel, data|
    	if data == 0 then
    		self.current_table = @table_owner
    		@controller.change_entity(0)
    		self.count_records = self.count_records_default
    	elsif data == 1 then
    		self.current_table = @table_guard
    		@controller.change_entity(1)
    		self.count_records = self.count_records_default
    	elsif data == 2 then
    		self.current_table = @table_auto
    		@controller.change_entity(2)
    		self.count_records = self.count_records_default
    	else
    		self.current_table = @table_owner		
    	end
    	print data,"\n"
    	 	@selected_items = []
    	 	showData(1,self.count_records)#@controller.refresh_data(1,self.count_records)
    end

   
    close_button = FXButton.new(horizontal_frame, "X", nil, nil, 0, :opts => BUTTON_NORMAL|LAYOUT_FILL_X)
    close_button.padLeft = 20
    close_button.padRight = 20
    close_button.padBottom = 10
    close_button.padTop = 10
    close_button.connect(SEL_COMMAND) { getApp().exit }


    horizontal_frame.layoutHints |= LAYOUT_BOTTOM|LAYOUT_LEFT|LAYOUT_RIGHT|LAYOUT_FILL_X
    tab_book.layoutHints |= LAYOUT_FILL_X|LAYOUT_FILL_Y
    close_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X	

  end
  
  	def showData(k,n,filter_initials:nil,filter_phone:nil,filter_mail:nil)
  		self.num_page = k
  		self.count_records_default = n if self.count_records_default == nil
  		max_count_entities = @controller.get_count_entities()
  		calculate_max_page(max_count_entities)
  		n = max_count_entities if max_count_entities < n
  		self.count_records = n
  		@controller.refresh_data(k,n,
  			filter_initials:filter_initials,
  			filter_phone:filter_phone,
  			filter_mail:filter_mail)
  	end

  	def set_table_params(column_names,whole_entites_count)
		self.current_table.set_table_params(column_names,whole_entites_count)
		#self.current_table.create_button_change_page()
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
	
		list_filters = initialize_filter(tab_frame,list_filters_name_input:["Surname N.L.: ","Phone"],
			list_filters_name_radio:["Наличие почты"])

		table = Table_persons.new(tab_frame,name_table)
		table.create_button_change_page()

		list_btn = initialize_control(tab_frame)

		events_entities_controls(table,list_btn[0],list_btn[1],list_btn[2],list_btn[3],modal_add:modal_create,modal_change:modal_update)
		event_filters_person(list_filters)
		table
	end


	def fillTab_auto(tab_book,name_table,modal_create:nil,modal_update:nil)
		tab_frame = FXHorizontalFrame.new(tab_book,LAYOUT_FILL_X|LAYOUT_FILL_Y)
		
		list_filters = initialize_filter(tab_frame,list_filters_name_input:["Surname owner","model","mark","color"],
			list_filters_name_radio:[])

		table = Table_auto.new(tab_frame,name_table)
		table.create_button_change_page()

		list_btn = initialize_control(tab_frame)

		FXLabel.new(tab_frame, "Expense Category:")
    	categories = FXComboBox.new(tab_frame, 6, :opts => COMBOBOX_INSERT_AFTER|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FIX_X|LAYOUT_FIX_Y|LAYOUT_FIX_WIDTH)
    	categories.numVisible = 6
    	categories.x = 810
    	categories.y = 140
    	categories.width = 100
    	categories.appendItem("Wining")
    	categories.appendItem("Dining")
    	categories.appendItem("Outright Bribery")
    	categories.sortItems

    	categories.connect(SEL_COMMAND) do |sender, sel, data|
      		#sender.sortItems
      		print sender.text
    	end


		events_entities_controls(table,list_btn[0],list_btn[1],list_btn[2],list_btn[3],modal_add:modal_create,modal_change:modal_update)
		event_filters_changed(filter_owner:list_filters[0],filter_model:list_filters[1],
			filter_mark:list_filters[2],filter_color:list_filters[3])

		#event_filters_person(list_filters)

		table
	end

	def initialize_filter(tab_frame,list_filters_name_input:,list_filters_name_radio:)
		filters = Filter.new 
		filter_area = filters.create_filter_area(tab_frame,180)
		list = []
		list_filters_name_input.each do |name|
			list.push(filters.add_filter_input(filter_area,name))
		end
		list_filters_name_radio.each do |name|
			list.push(filters.add_filter_radioBtn(filter_area,name))
		end
		list.push(filters.add_controlBtn(filter_area))
		list	
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

		ed.disable
		del.disable
		
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

	def event_filters_person(filters)	
		event_filters_verify(filter_initials:filters[0],filter_phone:filters[1])
		event_filters_changed(filter_initials:filters[0],filter_phone:filters[1])
		event_filter_btn_action(filters)
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

	def event_filters_changed(filter_initials:nil,filter_phone:nil,
		filter_model:nil,
		filter_owner:nil,
		filter_color:nil,
		filter_mark:nil)
		
		if filter_initials!=nil then
			event_filter_Text(filter_initials) { self.current_table.filter_data(filter_surname_initials:filter_initials.text) }
		end
		if filter_model!=nil then
			event_filter_Text(filter_model) { self.current_table.filter_data(filter_model:filter_model.text) }
		end
		if filter_mark!=nil then
			event_filter_Text(filter_mark) { self.current_table.filter_data(filter_mark:filter_mark.text) }
		end
		if filter_color!=nil then
			event_filter_Text(filter_color) { self.current_table.filter_data(filter_color:filter_color.text) }
		end
		if filter_owner!=nil then
			event_filter_Text(filter_owner) { self.current_table.filter_data(filter_owner:filter_owner.text) }
		end
	
		if(filter_phone!=nil) then
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
	end

	def event_filter_Text(filter)
		filter.connect(SEL_CHANGED) do
		raise "Table is empty" if self.current_table.table.numRows == 0
			if filter.text!=nil and filter.text != "" then
				if filter.text.match(/^[A-zА-яЁё\s\.0-9]+$/) then
					yield #self.current_table.filter_data(filter_surname_initials:filter_initials.text)
				end				
			else
				self.current_table.filter_data()
			end	 
		end
	end

	def event_filter_btn_action(list_btn_filter)
		update_btn = list_btn_filter[3][0]
		discard_btn = list_btn_filter[3][1]
		update_btn.connect(SEL_COMMAND) do |sender,sel,data|
			filter_initials = list_btn_filter[0].text
			filter_phone = list_btn_filter[1].text
			filter_mail = "NULL" if(list_btn_filter[2][0].value == 1)
			filter_mail = list_btn_filter[2][1].text if list_btn_filter[2][0].value == 0
			filter_mail = nil if list_btn_filter[2][0] == 2
			showData(self.num_page,self.count_records,
				filter_initials:filter_initials,
				filter_phone:filter_phone,
				filter_mail:filter_mail)

    	end

    	discard_btn.connect(SEL_COMMAND) do |sender,sel,data|
			list_btn_filter[0].text = ''
			list_btn_filter[1].text = ''
			list_btn_filter[2][1].text = ''
			list_btn_filter[2][1].disable
			list_btn_filter[2][0].value = 2
			showData(self.num_page,self.count_records)
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

