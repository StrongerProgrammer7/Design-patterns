

require 'fox16'

include Fox

class Student_list_view < FXMainWindow

  
  def initialize(app,controller)
  	@student_list_controller = controller
    # Call the base class initializer first
    super(app, "Students list", :width => 1000, :height => 600)
	
    # Create a horizontal frame to hold the tab book and status bar
    horizontal_frame = FXHorizontalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
	
    # Create a tab book widget
    tab_book = FXTabBook.new(horizontal_frame, :opts => LAYOUT_FILL_X|LAYOUT_FILL_Y)


    # Create the first tab
    tab1 = FXTabItem.new(tab_book, "Tab 1")
	
	#              FXVerticalFrame
	tab1_frame = FXHorizontalFrame.new(tab_book,LAYOUT_FILL_X|LAYOUT_FILL_Y)
	
	initialize_filter(tab1_frame)
	
	# Create the table in the center
	intialize_table(tab1_frame)
	
	#@update_btn.connect(SEL_COMMAND) do
	#	print @filter_git
	#	print @filter_mail
	#end
	@filter_surname.connect(SEL_CHANGED) do
			if @filter_surname.text!=nil and  @filter_surname.text != "" then
				if /^[A-zА-яЁё]*$/.match(@filter_surname.text)!=nil then
					@table_student.fill_table(Integer(@table_student.page_label.text[0]),3, filter_surname_initials:@filter_surname.text)
				end				
			else
				@table_student.fill_table(Integer(@table_student.page_label.text[0]),2)
			end
		
			#@total_pages = (self.table.numRows/self.count_people.to_f).ceil
			#@page_label.text = "1 of #{@total_pages}"
			#
			#if(self.count_people > 0) then
			#	fill_table(Integer(@page_label.text[0]),self.count_people)
			#end
		end
	# Create the control area on the right
	initialize_control(tab1_frame)
    
	
    createTab(tab_book,"Tab 2")
    createTab(tab_book, "Tab 3")

    # Create a status bar at the bottom of the window
    status_bar = FXStatusBar.new(horizontal_frame, LAYOUT_SIDE_BOTTOM|LAYOUT_FILL_X)
	
	# Create a close button and add it to the main frame
    close_button = FXButton.new(horizontal_frame, "Close", nil, nil, 0, LAYOUT_FILL_X)
    close_button.connect(SEL_COMMAND) { getApp().exit }

    # Add the tab book and close button to the main frame
    horizontal_frame.layoutHints |= LAYOUT_BOTTOM|LAYOUT_LEFT|LAYOUT_RIGHT|LAYOUT_FILL_X
    tab_book.layoutHints |= LAYOUT_FILL_X|LAYOUT_FILL_Y
    close_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
	
    # Show the window
    show(PLACEMENT_SCREEN)
		
  end
  
  private 
	attr_accessor :student_list_controller
	def initialize_filter(tab_frame)
		@filters = Filter.new 
		filter_area = @filters.create_filter_area(tab_frame,180)
		@filter_surname = @filters.add_filter_input(filter_area)
		@filter_git = @filters.add_filter_radioBtn(filter_area,@filter_git,"Наличие гита")
		@filter_mail = @filters.add_filter_radioBtn(filter_area,@filter_mail,"Наличие почты")
		@filter_telegram = @filters.add_filter_radioBtn(filter_area,@filter_mail,"Наличие телеграмма")
		@filter_phone = @filters.add_filter_radioBtn(filter_area,@filter_mail,"Наличие телефона")
		@update_btn = @filters.add_controlBtn(filter_area)
		
	end
	
	def intialize_table(tab_frame)
			
		# Add some data to the table
		datas = @student_list_controller.refresh_data(1,10)
		print datas
		data = [
			["Doe J.J.", "johndoe@example.com", "+1234567890", "@johndoe", "github.com/johndoe"],
			["Smith J. A.", "janesmith@example.com", "+0987654321", "@janesmith", "github.com/janesmith"],
			["Lee B. H.", "davidlee@example.com", "+1111111111", "@davidlee", "github.com/davidlee"],
			["Lee A. S.", "davidlee@example.com", "+1111111111", "@davidlee", "github.com/davidle1e"],
			["Lee D.H.", "davidlee@example.com", "+1111111111", "@davidlee", ""],
			["Doe J.J.", "johndoe@example.com", "+1234567890", "@johndoe", "github.com/johndoe"],
			["Smith J. A.", "janesmith@example.com", "+0987654321", "@janesmith", "github.com/janesmith"],
			["Lee B. H.", "davidlee@example.com", "+1111111111", "@davidlee", "github.com/davidlee"],
			["Lee A. S.", "davidlee@example.com", "+1111111111", "@davidlee", "github.com/davidle1e"],
			["Lee D.H.", "davidlee@example.com", "+1111111111", "@davidlee", ""]
		]
		@table_student = Table.new(data,["Surname N.L.","Mail","Phone","Telegram","Git"],tab_frame)
		@table_student.create_button_change_page()
		
		#print @table.rowHeader
		
	end

	def set_table_params(column_names,whole_entites_count)
		@table_student.set_table_params(column_names,whole_entites_count)
	end
	
	def set_table_data(data_table)
		@table_student.set_table_data(data_table)
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
	
	def createTab(tab_book, name_tab)
		# Create the second tab
    tab = FXTabItem.new(tab_book, name_tab)

    # Add a label to the second tab : After delete
    label = FXLabel.new(tab_book, "This is new tab")
    label.justify = JUSTIFY_CENTER_X|JUSTIFY_CENTER_Y
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
	
	def add_filter_input(filtering_area)
		FXLabel.new(filtering_area, "Surname N.L.: ")
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
	attr_accessor :table, :page_label
	attr_reader :data, :vframe_table, :count_people
	
	def initialize(data,names_col,tab_frame, width_frame:620,table_height:400,count_people:2)
		raise "Data is empty!" if data.length == 0 || names_col.length == 0
		self.data = data
		self.vframe_table = FXVerticalFrame.new(tab_frame, :opts => LAYOUT_FILL_X|LAYOUT_FIX_WIDTH)
		self.vframe_table.width = width_frame
		
		table_area = FXGroupBox.new(self.vframe_table, "Table Area", LAYOUT_FILL_X|LAYOUT_FILL_Y)
		
		self.table = FXTable.new(table_area, nil, 0,
		LAYOUT_SIDE_LEFT|LAYOUT_FILL_X|LAYOUT_FIX_HEIGHT|TABLE_READONLY|TABLE_COL_SIZABLE|TABLE_ROW_SIZABLE|TABLE_NO_ROWSELECT)
		self.table.height = table_height
		
		self.table.setTableSize(data.length, data[0].length)
		
		self.count_people = count_people
		setHeaderText(names_col)
		self.table.rowHeaderWidth = 40
		fill_table(1,self.count_people)
		
		header = self.table.columnHeader
		header.connect(SEL_COMMAND) do |sender, selector, data|
			print data
			@data = self.data.sort_by { |row| row[data] }
			fill_table(Integer(self.page_label.text[0]),self.count_people)
			
		end
		
		
		
	end
	
	def setHeaderText(names)
		column = 0
		names.each do |name|
			self.table.setColumnText(column, name) if column < names.length
			column+=1
		end
		self.table.setColumnWidth((names.length-1), 200)
	end
		
	def fill_table(num_page,count, filter_git:nil,filter_mail:nil,filter_telegram:nil,filter_phone:nil,
	filter_surname_initials:nil)
		clear_table((self.data[0].length-1),(self.data.length - 1))
		ind = 0
		row = 0
		begin_ = count * num_page - count
		begin_ = 0 if(num_page == 0) 
			
		self.data.each do |row_data|
			column = 0
			
			if(ind >= begin_ and ind < count*num_page) then
				if(filter_surname_initials!=nil) then
					#print filter_surname_initials
					if row_data[0].include? filter_surname_initials then
						row_data.each do |cell_data|
							self.table.setItemText(row, column, cell_data)
							column += 1
						end
						self.table.setRowText(row,(row+1).to_s)
						row +=1
					end
				else
					row_data.each do |cell_data|
						self.table.setItemText(row, column, cell_data)
						column += 1
					end
					self.table.setRowText(row,(row+1).to_s)
					row +=1
					
				end
				
			end
			
			ind +=1
			if(ind > count * num_page) then 
				break 
			else
				
			end
		end
    end
	
	def create_button_change_page()
		
		# Add buttons for changing pages
		button_layout = FXHorizontalFrame.new(self.vframe_table,:opts => LAYOUT_FILL_X|LAYOUT_SIDE_BOTTOM)
		prev_button = FXButton.new(button_layout, "Previous",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_LEFT,:padTop=> 10,:padBottom=> 10)
		next_button = FXButton.new(button_layout, "Next",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_RIGHT,:padTop=> 10,:padBottom=> 10)
		
		display_numPage_countPage(button_layout)
		
		prev_button.connect(SEL_COMMAND) do
			current_page = Integer(self.page_label.text[0])
			if current_page > 1
				current_page -= 1
				self.page_label.text = "#{current_page} of #{@total_pages}"
				fill_table(current_page,self.count_people)
			end
		end
		next_button.connect(SEL_COMMAND) do
			current_page = Integer(self.page_label.text[0])
			if current_page < @total_pages
				current_page += 1
				self.page_label.text = "#{current_page} of #{@total_pages}"
				fill_table(current_page,self.count_people)
			end
		end
	
	end
	
	
	
	private
		attr_accessor :data, :vframe_table, :count_people
		
	def clear_table(count_col,count_row)
		row = 0		
		loop do
			column =0
			loop do
				self.table.setRowText(row,"")
				break if(column > count_col)
				self.table.setItemText(row, column, "")
				column+=1
			end 
			break if row > count_row - 1
			row +=1
		end
		#print self.table.columnHeader
   end
   
   #def isIncludeToFilter(row, filter_git:nil,filter_mail:nil,filter_telegram:nil,filter_phone:nil,
#	filter_surname_initials:nil)
#		return true if filter_git==nil and filter_mail==nil and filter_telegram == nil and filter_phone == nil	and filter_surname_initials == nil
#		filter_accept = false
#		row.each do |elem|
#			
#		end	
 #  end
   
   def display_numPage_countPage(button_layout,pos_x:300)
		self.page_label = FXLabel.new(button_layout, "1", :opts => LAYOUT_FIX_X)
		self.page_label.x = pos_x
		
		@total_label = FXLabel.new(button_layout, "Total elements: 0",:opts => LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		@total_label.x = 20
		@total_label.y = 50
		count_people_lable = FXLabel.new(button_layout, "Count people ",:opts => LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		count_people_lable.x = 20
		count_people_lable.y = 80
		count_people_input = FXTextField.new(button_layout, 15, :opts => TEXTFIELD_NORMAL|LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		count_people_input.x = 20
		count_people_input.y = 100
		count_people_input.text = self.count_people.to_s
		
		count_people_input.connect(SEL_CHANGED) do
			if count_people_input.text!=nil and  count_people_input.text != "" then
				if /^[0-9]*$/.match(count_people_input.text)!=nil then
					self.count_people = Integer(count_people_input.text)
				end				
			else
				self.count_people = 1
			end
		
			@total_pages = (self.table.numRows/self.count_people.to_f).ceil
			self.page_label.text = "1 of #{@total_pages}"
		
			if(self.count_people > 0) then
				fill_table(Integer(self.page_label.text[0]),self.count_people)
			end
		end
				
		@total_pages = (table.numRows / self.count_people.to_f).ceil
		self.page_label.text = "1 of #{@total_pages}"
		
		update_total_label
		
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
application = FXApp.new
main_window = Student_list_view.new(application)
application.create
main_window.show(PLACEMENT_SCREEN)
application.run
