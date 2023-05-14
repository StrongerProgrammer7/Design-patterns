require_relative File.dirname($0) + './view/button_control_view.rb'
require_relative File.dirname($0) + './view/filter_control_view.rb'
require_relative File.dirname($0) + './view/tables/table__students_control_view.rb'
require_relative File.dirname($0) + './view/tables/table_labs.rb'

require 'fox16'

include Fox

class Student_list_view < FXMainWindow

	attr_reader :count_records, :num_page, :current_table
	attr_writer :student_list_controller
  def initialize(app,modal_create_student:nil,modal_change_student:nil,modal_create_lab:nil,modal_change_lab:nil)

  	@labs_list_controller = nil
  	
  	self.modal_window_create_student = modal_create_student
  	self.modal_window_change_student = modal_change_student
  	self.modal_window_create_lab = modal_create_lab
  	self.modal_window_change_lab = modal_change_lab
    super(app, "Students list", :width => 1000, :height => 600)
	
    horizontal_frame = FXHorizontalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
	
    tab_book = FXTabBook.new(horizontal_frame)


		createTab(tab_book,"Students")
		fillTab_students(tab_book)

    createTab(tab_book,"Labs")
    fillTab_labs(tab_book)
    createTab(tab_book, "Tab 3")
    createLabelByCenter(tab_book)

    tab_book.connect(SEL_COMMAND) do |sender, sel, data|
    	if data == 0 then
    		self.current_table = @table_student
    		@student_list_controller.change_entity()
    		self.count_records = 30
    	elsif data == 1 then
    		self.current_table = @table_labs
    		@student_list_controller.change_entity()
    		self.count_records = 16
    	else
    		self.current_table = @table_student
    		
    	end
    		#pos = self.current_table.num_current_page.text.index(" ")
    	 	#current_page = Integer(self.current_table.num_current_page.text.slice(0,pos))
    	 	clearSelect()
    	 	@student_list_controller.refresh_data(1,self.count_records)
    		#showData(self.num_page,self.count_records) if (data==0)
    end
    
    close_button = FXButton.new(horizontal_frame, "Close", nil, nil, 0, LAYOUT_FILL_X)
    close_button.connect(SEL_COMMAND) { getApp().exit }

    horizontal_frame.layoutHints |= LAYOUT_BOTTOM|LAYOUT_LEFT|LAYOUT_RIGHT|LAYOUT_FILL_X
    tab_book.layoutHints |= LAYOUT_FILL_X|LAYOUT_FILL_Y
    close_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
		
  end
  
  def showData(k,n)
  	self.num_page = k
  	self.count_records = n
  	self.max_page_data = (@student_list_controller.get_count_entities() / n) + 1
  	@student_list_controller.refresh_data(k,n)
  end

  def set_table_params(column_names,whole_entites_count)
		self.current_table.set_table_params(column_names,whole_entites_count)
		self.current_table.create_button_change_page()
		initializeButtonTable_getData()
	end
	
	def set_table_data(data_table)
			self.current_table.set_table_data(data_table) if data_table!=[] and data_table!=nil
	end

  private 
	attr_accessor :max_page_data, :modal_window_create_student, :modal_window_change_student,:modal_window_create_lab, :modal_window_change_lab
	attr_writer :count_records, :num_page, :current_table
	attr_reader :student_list_controller
	
	def createTab(tab_book, name_tab)
    tab = FXTabItem.new(tab_book, name_tab)
	end

	def createLabelByCenter(tab_book)
    label = FXLabel.new(tab_book, "This is new tab")
    label.justify = JUSTIFY_CENTER_X|JUSTIFY_CENTER_Y
	end

	def fillTab_students(tab_book)
			#              FXVerticalFrame
		tab_frame = FXHorizontalFrame.new(tab_book,LAYOUT_FILL_X|LAYOUT_FILL_Y)
	
		initialize_filter(tab_frame)

		@table_student = Table_students.new(tab_frame,"Students table")
		self.current_table = @table_student

		list_btn = initialize_control(tab_frame)

		events_entities_controls(@table_student,list_btn[0],list_btn[1],list_btn[2],list_btn[3],modal_add:self.modal_window_create_student,modal_change:self.modal_window_change_student)

		@filter_surname.connect(SEL_CHANGED) do
			raise "Table is empty" if @table_student.table.numRows == 0
				if @filter_surname.text!=nil and @filter_surname.text != "" then
					if /^[A-zА-яЁё]*$/.match(@filter_surname.text)!=nil then
						@table_student.filter_data(filter_surname_initials:@filter_surname.text)
					end				
				else
					@table_student.filter_data()
				end	
		end
	end

	def fillTab_labs(tab_book)
		tab_frame = FXHorizontalFrame.new(tab_book,LAYOUT_FILL_X|LAYOUT_FILL_Y)
		
		@table_labs = Table_lab_works.new(tab_frame,"Labs table")
	
		list_btn = initialize_control(tab_frame)
		events_entities_controls(@table_labs,
			list_btn[0],list_btn[1],list_btn[2],list_btn[3],
			modal_add:self.modal_window_create_lab,
			modal_change:self.modal_window_change_lab)
		
		list_btn[3].connect(SEL_COMMAND) do |sender,sel,data|	
			clearSelect()
			disable_button_edit_delete(list_btn[1],list_btn[2])
			@student_list_controller.refresh_data(1,self.count_records)
    end
	end

	def initialize_filter(tab_frame)
		@filters = Filter.new 
		filter_area = @filters.create_filter_area(tab_frame,180)
		@filter_surname = @filters.add_filter_input(filter_area,"Surname N.L.: ")
		@filter_git = @filters.add_filter_radioBtn(filter_area,@filter_git,"Наличие гита")
		@filter_mail = @filters.add_filter_radioBtn(filter_area,@filter_mail,"Наличие почты")
		@filter_telegram = @filters.add_filter_radioBtn(filter_area,@filter_mail,"Наличие телеграмма")
		@filter_phone = @filters.add_filter_radioBtn(filter_area,@filter_mail,"Наличие телефона")
		@update_btn = @filters.add_controlBtn(filter_area)
		
	end
	

	def initializeButtonTable_getData()
			@table_student.next_data_button.connect(SEL_COMMAND) do |sender,sel,data|
				if(self.num_page < self.max_page_data) then
					self.num_page+=1
					@table_student.label_num_current_page_data.text = "#{self.num_page} page of #{self.max_page_data} data"
    	 		showData(self.num_page,self.count_records)
    	 		@selected_items=[]
    	 	end 
    	end

    	@table_student.prev_data_button.connect(SEL_COMMAND) do |sender,sel,data|
    		if(self.num_page > 1) then
    			self.num_page-=1
    			@table_student.label_num_current_page_data.text = "#{self.num_page} page of #{self.max_page_data} data" 
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
		disable_button_edit_del(ed,del)

		event_table_selected(table,ed,del)
		event_table_deselected(table,ed,del)	
		
		event_addEntity(modal_add,add)
		event_delete_entity(ed,del)
		event_change_entity(modal_change,ed,del)
	end


	def disable_button_edit_del(ed,del)
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
			if (self.current_table.to_s.include? "Table_lab_works") then
					if current_table.count_data.to_i - 1 == @selected_items[0].to_i && @selected_items.length == 1
						del_btn.enable
					else
						del_btn.disable
					end
				end
			self.student_list_controller.select_entity(data.row.to_s) if item != '' and item != nil
		end
	end

	def event_table_deselected(current_table,ed_btn,del_btn)
		current_table.table.connect(SEL_DESELECTED) do |sender, sel, pos|
			@selected_items.delete(pos.row.to_s) #pos.row pos.col
			self.student_list_controller.deselected_entity(pos.row.to_s)
			if @selected_items.length == 0 then
				disable_button_edit_delete(ed_btn,del_btn)
			end
		end
	end

	def clearSelect()
		@selected_items.each do |elem| 
			self.student_list_controller.deselected_entity(elem.to_s)
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
			id = self.student_list_controller.get_selected()[0]
			modal_window_change.get_personal_data_student(id)
			modal_window_change.addTimeoutCheck(data:self.current_table.data)
			@selected_items = []
			disable_button_edit_delete(ed_btn,del_btn)
    end
	end

	def event_delete_entity(ed,del_btn)
		del_btn.connect(SEL_COMMAND) do |sender,sel,data|
    	self.student_list_controller.delete_entities()
    	@selected_items = []
    	disable_button_edit_delete(ed,del_btn)
    end
	end

	def disable_button_edit_delete(ed,del)
		if @selected_items.length <= 0 then
			ed.disable
			del.disable
		end
	end
end

