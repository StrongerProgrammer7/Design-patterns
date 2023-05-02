
require_relative File.dirname($0) + './controller/student_list_controller.rb'
require 'fox16'

include Fox

class Student_list_view < FXMainWindow

  def initialize(app,controller)
  	@student_list_controller = controller

    super(app, "Students list", :width => 1000, :height => 600)
	
    # Create a horizontal frame to hold the tab book and status bar
    horizontal_frame = FXHorizontalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
	
    # Create a tab book widget
    tab_book = FXTabBook.new(horizontal_frame)

    # Create the first tab

		createTab(tab_book,"Tab 1")
		fillTab(tab_book)
   #TODO при переключении табов , добавить прослушиватель, который вызовет метод refreshData
   #TODO make sort by only display data
    createTab(tab_book,"Tab 2")
    createTab(tab_book, "Tab 3")

	# Create a close button and add it to the main frame
    close_button = FXButton.new(horizontal_frame, "Close", nil, nil, 0, LAYOUT_FILL_X)
    close_button.connect(SEL_COMMAND) { getApp().exit }

    # Add the tab book and close button to the main frame
    horizontal_frame.layoutHints |= LAYOUT_BOTTOM|LAYOUT_LEFT|LAYOUT_RIGHT|LAYOUT_FILL_X
    tab_book.layoutHints |= LAYOUT_FILL_X|LAYOUT_FILL_Y
    close_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
	
		
  end
  
  def showData(k,n)
  	@student_list_controller.refresh_data(k,n)
  end

  def set_table_params(column_names,whole_entites_count)
		@table_student.set_table_params(column_names,whole_entites_count)
		@table_student.create_button_change_page()
	end
	
	def set_table_data(data_table)
		@table_student.set_table_data(data_table)
	end

  private 
	attr_accessor :student_list_controller

	def createTab(tab_book, name_tab)
    tab = FXTabItem.new(tab_book, name_tab)

    # Add a label to the second tab : After delete
    #label = FXLabel.new(tab_book, "This is new tab")
   # label.justify = JUSTIFY_CENTER_X|JUSTIFY_CENTER_Y
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
					current_page = @table_student.num_current_page.text.slice(0,@table_student.num_current_page.text.index(" "))
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

class Filter < FXMainWindow

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
		#add_filter_radioBtn(filtering_area,@filter_git,"Наличие гита")
		#add_filter_radioBtn(filtering_area,@filter_mail,"Наличие почты")
		#add_filter_radioBtn(filtering_area,@filter_mail,"Наличие телеграмма")
		#add_filter_radioBtn(filtering_area,@filter_mail,"Наличие телефона")
		
		
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

class Table < FXMainWindow
	attr_accessor :table,:num_current_page, :current_data
	attr_reader :data, :vframe_table, :whole_entites_count
	
	def initialize(tab_frame, width_frame:620,table_height:400)
		self.vframe_table = FXVerticalFrame.new(tab_frame, :opts => LAYOUT_FILL_X|LAYOUT_FIX_WIDTH)
		self.vframe_table.width = width_frame
		
		table_area = FXGroupBox.new(self.vframe_table, "Table Area", LAYOUT_FILL_X|LAYOUT_FILL_Y)
		
		self.table = FXTable.new(table_area, nil, 0,
		LAYOUT_SIDE_LEFT|LAYOUT_FILL_X|LAYOUT_FIX_HEIGHT|TABLE_READONLY|TABLE_COL_SIZABLE|TABLE_ROW_SIZABLE)
		self.table.height = table_height
		

		self.table.rowHeaderWidth = 40
		
		self.table.columnHeader.connect(SEL_COMMAND) do |sender, selector, data|
			current_page = self.num_current_page.text.slice(0,self.num_current_page.text.index(" "))
			if(self.current_data != nil && self.current_data.length != 0) then
				self.current_data = self.current_data.sort_by { |row| row[data] if row[data]!=nil or row[data]!='' }
				fillSortData(Integer(current_page),self.whole_entites_count,self.current_data)
				#if (checkbox_full_sort===true) then 
					#self.data = self.data.sort_by { |row| row[data] if row[data]!=nil or row[data]!='' }
					#fill_table(Integer(current_page),self.whole_entites_count)
				#end
				
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
		
		# Add buttons for changing pages
		button_layout = FXHorizontalFrame.new(self.vframe_table,:opts => LAYOUT_FILL_X|LAYOUT_SIDE_BOTTOM)
		prev_button = FXButton.new(button_layout, "Previous",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_LEFT,:padTop=> 10,:padBottom=> 10)
		next_button = FXButton.new(button_layout, "Next",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_RIGHT,:padTop=> 10,:padBottom=> 10)
		
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
	
	end
	
	private
		attr_accessor :data, :vframe_table, :whole_entites_count

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
   #def isIncludeToFilter(row, filter_git:nil,filter_mail:nil,filter_telegram:nil,filter_phone:nil,
#	filter_surname_initials:nil)
#		return true if filter_git==nil and filter_mail==nil and filter_telegram == nil and filter_phone == nil	and filter_surname_initials == nil
#		filter_accept = false
#		row.each do |elem|
#			
#		end	
 #  end
   
   def display_numPage_countPage(button_layout,pos_x:300)
		self.num_current_page = FXLabel.new(button_layout, "1", :opts => LAYOUT_FIX_X)
		self.num_current_page.x = pos_x
		
		@total_label = FXLabel.new(button_layout, "Total elements: 0",:opts => LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		@total_label.x = 20
		@total_label.y = 50

		whole_entites_count_label = FXLabel.new(button_layout, "Count people ",:opts => LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		whole_entites_count_label.x = 20
		whole_entites_count_label.y = 80

		whole_entites_count_input = FXTextField.new(button_layout, 15, :opts => TEXTFIELD_NORMAL|LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		whole_entites_count_input.x = 20
		whole_entites_count_input.y = 100
		whole_entites_count_input.text = self.whole_entites_count.to_s
		
		whole_entites_count_input.connect(SEL_CHANGED) do
			if whole_entites_count_input.text!=nil and  whole_entites_count_input.text != "" then
				if /^[0-9]*$/.match(whole_entites_count_input.text)!=nil then
					self.whole_entites_count = Integer(whole_entites_count_input.text)
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
		
		#update_total_label
		
	end
	
    def update_total_label
		total_elements = self.table.numRows * self.table.numColumns
		@total_label.text = "Total elements: #{total_elements}"
	end
end

class Button_control < FXMainWindow
	def initialize(tab_frame,width:200)
		@control_area = FXGroupBox.new(tab_frame, "Control Area", :opts=> LAYOUT_FIX_WIDTH)
		@control_area.width = 200
	end
	
	def createButton(name)
		FXButton.new(@control_area, name)
	end
end

# Start the application
#application = FXApp.new
#main_window = Student_list_view.new(application)
#application.create
#main_window.show(PLACEMENT_SCREEN)
#application.run
