require_relative File.dirname($0) + './view/button_control_view.rb'
require_relative File.dirname($0) + './view/filter_control_view.rb'
require_relative File.dirname($0) + './view/tables/table__students_control_view.rb'
require_relative File.dirname($0) + './view/tables/table_labs.rb'

require 'fox16'

include Fox

class Student_list_view < FXMainWindow

	attr_reader :count_records, :num_page

  def initialize(app,controller,modal_create:nil,modal_change:nil)
  	@student_list_controller = controller
  	self.modal_window_create_student = modal_create
  	self.modal_window_change_student = modal_change

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
    		pos = @table_student.num_current_page.text.index(" ")
    	 	current_page = Integer(@table_student.num_current_page.text.slice(0,pos))
    		showData(self.num_page,self.count_records) if (data==0)
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
  	self.max_page_data = (@student_list_controller.get_count_student_short() / n) + 1
  	@student_list_controller.refresh_data(k,n)
  end

  def set_table_params(column_names,whole_entites_count)
		@table_student.set_table_params(column_names,whole_entites_count)
		@table_student.create_button_change_page()
		initializeButtonTable_getData()
	end
	
	def set_table_data(data_table)
			@table_student.set_table_data(data_table) if data_table!=[] and data_table!=nil
	end

  private 
	attr_accessor :student_list_controller ,:max_page_data, :modal_window_create_student, :modal_window_change_student
	attr_writer :count_records, :num_page
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
	
		intialize_table_students(tab_frame,"Students table")
	
		list_btn = initialize_control(tab_frame)
		events_students_controls(list_btn[0],list_btn[1],list_btn[2])
		
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
	
		initialize_control(tab_frame)
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
	
	def intialize_table_students(tab_frame,name_table)
		@table_student = Table_students.new(tab_frame,name_table)
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

		return [add,ed,del]
	end

	def events_students_controls(add,ed,del)
		ed.disable
		del.disable

		event_table_selected(ed,del)
		event_table_deselected(ed,del)	
		
		event_addStudent(add)
		event_deleteStudent(ed,del)
		event_changeStudent(ed,del)
	end

	def event_table_selected(ed_btn,del_btn)
		@selected_items = []
		@table_student.table.connect(SEL_SELECTED) do |sender, selector, data|
			item = sender.getItem(data.row, 0) #data.col	
			@selected_items << data.row.to_s unless @selected_items.include? data.row.to_s
			if @selected_items.length > 1 then
				ed_btn.disable
				del_btn.enable
			elsif @selected_items.length == 1 then
				ed_btn.enable
				del_btn.enable
			else
				disable_button_edit_delete(ed_btn,del_btn)
			end
			self.student_list_controller.select_student(item.to_s)
		end
	end

	def event_table_deselected(ed_btn,del_btn)
		@table_student.table.connect(SEL_DESELECTED) do |sender, sel, pos|
			@selected_items.delete(pos.row.to_s) #pos.row pos.col
			if @selected_items.length == 0 then
				disable_button_edit_delete(ed_btn,del_btn)
			end
		end
	end

	def event_addStudent(add_btn)
		add_btn.connect(SEL_COMMAND) do |sender,sel,data|	
			self.modal_window_create_student.show(PLACEMENT_SCREEN)
			self.modal_window_create_student.addTimeoutCheck()
    end
	end

	def event_changeStudent(ed_btn,del_btn)
		ed_btn.connect(SEL_COMMAND) do |sender,sel,data|	
			self.modal_window_change_student.show(PLACEMENT_SCREEN)	
			id = self.student_list_controller.get_selected()[0]
			self.modal_window_change_student.get_personal_data_student(id)
			self.modal_window_change_student.addTimeoutCheck()
			@selected_items = []
			disable_button_edit_delete(ed_btn,del_btn)
    end
	end

	def event_deleteStudent(ed,del_btn)
		del_btn.connect(SEL_COMMAND) do |sender,sel,data|
    	self.student_list_controller.delete_student()
    	@selected_items.each do |num|
    		@table_student.delete_student_from_data(num.to_i)
    	end
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

