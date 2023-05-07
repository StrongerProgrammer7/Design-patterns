require_relative File.dirname($0) + './view/button_control_view.rb'
require_relative File.dirname($0) + './view/filter_control_view.rb'
require_relative File.dirname($0) + './view/table_control_view.rb'
require_relative File.dirname($0) + './view/modal_window_create_student.rb'
require_relative File.dirname($0) + './controller/student_list_controller.rb'
require 'fox16'
require 'clipboard'

include Fox

class Student_list_view < FXMainWindow

	attr_reader :count_records, :num_page

  def initialize(app,controller,modal)
  	@student_list_controller = controller
  	self.modal_window_create_student = modal

    super(app, "Students list", :width => 1000, :height => 600)
	
    horizontal_frame = FXHorizontalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
	
    tab_book = FXTabBook.new(horizontal_frame)


		createTab(tab_book,"Tab 1")
		fillTab(tab_book)

    createTab(tab_book,"Tab 2")
    createLabelByCenter(tab_book)
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
	attr_accessor :student_list_controller ,:max_page_data, :modal_window_create_student
	attr_writer :count_records, :num_page
	def createTab(tab_book, name_tab)
    tab = FXTabItem.new(tab_book, name_tab)
	end

	def createLabelByCenter(tab_book)
    label = FXLabel.new(tab_book, "This is new tab")
    label.justify = JUSTIFY_CENTER_X|JUSTIFY_CENTER_Y
	end

	def fillTab(tab_book)
			#              FXVerticalFrame
		tab_frame = FXHorizontalFrame.new(tab_book,LAYOUT_FILL_X|LAYOUT_FILL_Y)
	
		initialize_filter(tab_frame)
	
		intialize_table(tab_frame)
	
		initialize_control(tab_frame)

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
	
	def intialize_table(tab_frame)
		@table_student = Table.new(tab_frame)
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
		@button_control = Button_control.new(tab_frame)
		add = @button_control.createButton("Add")
		ed = @button_control.createButton("Edit")
		del = @button_control.createButton("Delete")

		ed.disable
		del.disable
		@selected_items = []
		@table_student.table.connect(SEL_SELECTED) do |sender, selector, data|
			item = sender.getItem(data.row, data.col)
			@selected_items << item unless @selected_items.include? item
			if @selected_items.length > 1 then
				ed.disable
				del.enable
			elsif @selected_items.length == 1 then
				ed.enable
				del.enable
			else
				ed.disable
				del.disable
			end
			if @selected_items.length == 0 then
				ed.disable
				del.disable
			end
		end
		
		@table_student.table.connect(SEL_DESELECTED) do |sender, sel, pos|
			@selected_items.delete(sender.getItem(pos.row, pos.col))
		end

		add.connect(SEL_COMMAND) do |sender,sel,data|	
			self.modal_window_create_student.show(PLACEMENT_SCREEN)
			self.modal_window_create_student.addTimeoutCheck()
    end

    del.connect(SEL_COMMAND) do |sender,sel,data|
    	print @selected_items
    end
	end
end

