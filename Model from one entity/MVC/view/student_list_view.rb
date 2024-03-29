
require_relative File.dirname($0) + './controller/student_list_controller.rb'
require 'fox16'

include Fox

class Student_list_view < FXMainWindow

  def initialize(app,controller)
  	@student_list_controller = controller

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
	attr_accessor :student_list_controller, :num_page, :count_records,:max_page_data

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
    	 	end 
    	end

    	@table_student.prev_data_button.connect(SEL_COMMAND) do |sender,sel,data|
    		if(self.num_page > 1) then
    			self.num_page-=1
    			@table_student.label_num_current_page_data.text = "#{self.num_page} page of #{self.max_page_data} data" 
    	 		showData(self.num_page,self.count_records) 
    	 	end
    	end
	end

	def initialize_control(tab_frame)
		@button_control = Button_control.new(tab_frame)
		@button_control.createButton("Add")
		ed = @button_control.createButton("Edit")
		del = @button_control.createButton("Delete")

		ed.disable
		del.disable
		selected_items = []
		@table_student.table.connect(SEL_SELECTED) do |sender, selector, data|
			item = sender.getItem(data.row, data.col)
			selected_items << item unless selected_items.include? item
			if selected_items.length > 1 then
				ed.disable
				del.enable
			elsif selected_items.length == 1 then
				ed.enable
				del.enable
			else
				ed.disable
				del.disable
			end
			if selected_items.length == 0 then
				ed.disable
				del.disable
			end
		end
		
		@table_student.table.connect(SEL_DESELECTED) do |sender, sel, pos|
			selected_items.delete(sender.getItem(pos.row, pos.col))
		end
	end
	
	
end

class Filter 

	def initialize()
		#create_filter_area(tab_frame,width)
	end
	
	def create_filter_area(tab_frame,width)
		# Create the filtering area on the left
		scroll_window = FXScrollWindow.new(tab_frame, :opts => LAYOUT_FIX_WIDTH|LAYOUT_FILL_Y|VSCROLLER_ALWAYS)
		scroll_window.width = width
		filtering_area = FXGroupBox.new(scroll_window, "Filtering Area")
		
		FXLabel.new(filtering_area, "Filter by:")
		
		return filtering_area		
	end
	
	def add_filter_input(filtering_area,name_filter_input)
		FXLabel.new(filtering_area, name_filter_input)
		return FXTextField.new(filtering_area, 15, :opts => TEXTFIELD_NORMAL)
	end

	def add_controlBtn(filtering_area)
		button_filter = FXHorizontalFrame.new(filtering_area,LAYOUT_FILL_X|LAYOUT_FILL_Y)
		update = FXButton.new(button_filter, "Обновить")
		FXButton.new(button_filter, "Сбросить")
		update
		
	end
	
	def add_filter_radioBtn(filtering_area,filter,name_group)

		filter = FXDataTarget.new(2)
		groups_radio = FXGroupBox.new(filtering_area, name_group, :opts => GROUPBOX_NORMAL|GROUPBOX_TITLE_LEFT|FRAME_GROOVE|LAYOUT_SIDE_TOP)
		FXRadioButton.new(groups_radio, "Есть",:target => filter, :selector => FXDataTarget::ID_OPTION)
		FXRadioButton.new(groups_radio, "Нет",:target => filter, :selector => FXDataTarget::ID_OPTION+1)
		FXRadioButton.new(groups_radio, "Не важно",:target => filter, :selector => FXDataTarget::ID_OPTION+2)
		
		# Add a text field widget to part 2 for entering text to search on the git
		FXLabel.new(groups_radio, "Search: ")
		search_field = FXTextField.new(groups_radio, 15, :opts => TEXTFIELD_NORMAL)
		search_field.disable
		
		filter.connect(SEL_COMMAND) do
			puts "The newly selected value is #{filter.value}"
			search_field.enable if filter.value == 0
			search_field.disable if filter.value > 0
			
		end
		filter
	end
	
end

class Table 
	attr_accessor :table,:num_current_page, :current_data, :prev_data_button,:next_data_button, :label_num_current_page_data
	attr_reader :data, :vframe_table, :whole_entites_count
	
	def initialize(tab_frame, width_frame:620,table_height:400)
		self.vframe_table = FXVerticalFrame.new(tab_frame, :opts => LAYOUT_FILL_X|LAYOUT_FIX_WIDTH)
		self.vframe_table.width = width_frame
		
		table_area = FXGroupBox.new(self.vframe_table, "Student table", LAYOUT_FILL_X|LAYOUT_FILL_Y)
		
		self.table = FXTable.new(table_area, nil, 0,
		LAYOUT_SIDE_LEFT|LAYOUT_FILL_X|LAYOUT_FIX_HEIGHT|TABLE_READONLY|TABLE_COL_SIZABLE|TABLE_ROW_SIZABLE)
		self.table.height = table_height
		

		self.table.rowHeaderWidth = 40
		
		self.table.columnHeader.connect(SEL_COMMAND) do |sender, selector, data|
			current_page = self.num_current_page.text.slice(0,self.num_current_page.text.index(" "))
			if(self.current_data != nil && self.current_data.length != 0) then
				if(self.chekbox_sort_all_data_toTable.checked?) then
					self.data = self.data.sort_by { |row| row[data] if row[data]!=nil or row[data]!='' }
					fill_table(Integer(current_page),self.whole_entites_count)
				else
					self.current_data = self.current_data.sort_by { |row| row[data] if row[data]!=nil or row[data]!='' }
					fillSortData(Integer(current_page),self.whole_entites_count,self.current_data)
				end
				
			end		
		end
		
	end

	def set_table_params(column_names,whole_entites_count)
		self.whole_entites_count = whole_entites_count
		self.table.setTableSize(whole_entites_count,column_names.length)
		setHeaderText(column_names)
		#print (self.table.numColumns)
	end

	def set_table_data(data_table)
		self.data = data_table
		fill_table(1,self.whole_entites_count) 
		#print (self.table.numRows)
	end

	def filter_data(filter_git:nil,filter_mail:nil,filter_telegram:nil,filter_phone:nil,
	filter_surname_initials:nil)
		fill_table(1,self.whole_entites_count,filter_git:filter_git,filter_mail:filter_mail,filter_telegram:filter_telegram,filter_phone:filter_phone,filter_surname_initials:filter_surname_initials)
	end

	def create_button_change_page()
		if(self.num_current_page==nil) then
			# Add buttons for changing pages
			button_layout = FXHorizontalFrame.new(self.vframe_table,:opts => LAYOUT_FILL_X|LAYOUT_SIDE_BOTTOM)
			self.prev_data_button = FXButton.new(button_layout, "Previous data",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_LEFT,:padTop=> 10,:padBottom=> 10)
			self.next_data_button = FXButton.new(button_layout, "Next data",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_RIGHT,:padTop=> 10,:padBottom=> 10)


			prev_button = FXButton.new(button_layout, "Previous page",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_LEFT,:padTop=> 10,:padBottom=> 10)
			next_button = FXButton.new(button_layout, "Next page",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_RIGHT,:padTop=> 10,:padBottom=> 10)
			
			

			display_numPage_countPage(button_layout)
			
			prev_button.connect(SEL_COMMAND) do
				current_page = Integer(self.num_current_page.text.slice(0,self.num_current_page.text.index(" ")))
				if current_page > 1
					current_page -= 1
					self.num_current_page.text = "#{current_page} of #{@total_pages}"
					fill_table(current_page,self.whole_entites_count)
				end
			end

			next_button.connect(SEL_COMMAND) do
				current_page = Integer(self.num_current_page.text.slice(0,self.num_current_page.text.index(" ")))
				if current_page < @total_pages
					current_page += 1
					self.num_current_page.text = "#{current_page} of #{@total_pages}"
					fill_table(current_page,self.whole_entites_count)
				end
			end
		else
			@whole_entites_count_input.text = self.whole_entites_count.to_s
			@total_pages = (self.table.numRows/self.whole_entites_count.to_f).ceil
			self.num_current_page.text = "1 of #{@total_pages}"
		end
	
	end
	
	private
		attr_accessor :data, :vframe_table, :whole_entites_count, :chekbox_sort_all_data_toTable

	def setHeaderText(column_names)
		num = 0
		column_names.each do |name|
			self.table.setColumnText(num, name) if num < column_names.length
			num+=1
		end
		self.table.setColumnWidth((0), 40)
		self.table.setColumnWidth((column_names.length-1), 200)
	end

	def clear_table(count_col,count_row)
		row = 0		
		loop do
			column =0
			loop do
				break if(column > count_col)
				self.table.setRowText(row,"")
				self.table.setItemText(row, column, "")
				column+=1
			end 
			break if row > count_row - 1
			row +=1
		end

   end

  def fill_table(num_page,count,filter_git:nil,filter_mail:nil,filter_telegram:nil,filter_phone:nil,
	filter_surname_initials:nil)
		clear_table((self.data[0].length-1),(self.data.length - 1))
		row = 0
		begin_ = if num_page != 0 then count * num_page - count else 0 end
		ind = begin_
		self.current_data = []
		loop do 
			row = checkRow(filter_surname_initials,ind,row)
			ind +=1
			if(ind >= count * num_page) then 
				break 
			end
		end
   end 

   #------- CHANGE NAME METHOD!
   def checkRow(filter_surname_initials,ind,row)
   		if(filter_surname_initials!=nil) then
					if self.data[ind][1].include? filter_surname_initials then
						fillRow(self.data[ind],row) 
						row +=1
					end
				else
					fillRow(self.data[ind],row)
					row +=1	
			end
			row
   end

   def fillRow(row_data,row)
   		column = 0
   		if(row_data!=nil) then
   			row_data.each do |cell_data|
						self.table.setItemText(row, column, cell_data.to_s)
						column += 1
				end
			self.table.setRowText(row,(row+1).to_s)
			self.current_data << row_data
		end
		
   end
#---------------------------------TODO--REFACTORING!!
   def fillSortData(num_page,count,data)
   		row = 0
			begin_ = if num_page != 0 then count * num_page - count else 0 end
			ind = 0
		loop do 
			displaySortCurrentData(data[ind],row)
			ind +=1
			row +=1
			if(ind >= count * num_page) then 
				break 
			end
		end
   end

   def displaySortCurrentData(row_data,row)
   	column = 0
   		if(row_data!=nil) then
   			row_data.each do |cell_data|
						self.table.setItemText(row, column, cell_data.to_s)
						column += 1
				end
			self.table.setRowText(row,(row+1).to_s)
		end
 	 end
#---------------------------------------------   

   def display_numPage_countPage(button_layout,pos_x:300)
		self.num_current_page = FXLabel.new(button_layout, "1", :opts => LAYOUT_FIX_X)
		self.num_current_page.x = pos_x


		whole_entites_count_label = FXLabel.new(button_layout, "Count people ",:opts => LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		whole_entites_count_label.x = 20
		whole_entites_count_label.y = 80

		@whole_entites_count_input = FXTextField.new(button_layout, 15, :opts => TEXTFIELD_NORMAL|LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		@whole_entites_count_input.x = 20
		@whole_entites_count_input.y = 100
		@whole_entites_count_input.text = self.whole_entites_count.to_s
		
		self.chekbox_sort_all_data_toTable = FXCheckButton.new(button_layout, " Sort all data in the table", :opts => LAYOUT_FIX_X|LAYOUT_FIX_Y|LAYOUT_SIDE_BOTTOM)

		self.chekbox_sort_all_data_toTable.x = 160
		self.chekbox_sort_all_data_toTable.y = 100


		@whole_entites_count_input.connect(SEL_CHANGED) do
			if @whole_entites_count_input.text!=nil and  @whole_entites_count_input.text != "" then
				if /^[0-9]*$/.match(@whole_entites_count_input.text)!=nil then
					self.whole_entites_count = Integer(@whole_entites_count_input.text)
				end				
			else
				self.whole_entites_count = 1
			end
		
			@total_pages = (self.table.numRows/self.whole_entites_count.to_f).ceil
			self.num_current_page.text = "1 of #{@total_pages}"
		
			if(self.whole_entites_count > 0) then
				current_page = self.num_current_page.text.slice(0,self.num_current_page.text.index(" "))
				fill_table(Integer(current_page),self.whole_entites_count)
			end
		end
				
		@total_pages = (table.numRows / self.whole_entites_count.to_f).ceil
		self.num_current_page.text = "1 of #{@total_pages}"

		self.label_num_current_page_data = FXLabel.new(button_layout, "",:opts => LAYOUT_FIX_X|LAYOUT_FIX_Y|LAYOUT_SIDE_BOTTOM)
		self.label_num_current_page_data.x = pos_x - 25
		self.label_num_current_page_data.y = 25

	end

end

class Button_control
	def initialize(tab_frame,width:200)
		@control_area = FXGroupBox.new(tab_frame, "Control Area", :opts=> LAYOUT_FIX_WIDTH)
		@control_area.width = 200
	end
	
	def createButton(name)
		FXButton.new(@control_area, name)
	end
end

