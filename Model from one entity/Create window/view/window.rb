require 'fox16'

include Fox

class MyMainWindow < FXMainWindow

  def initialize(app)
    # Call the base class initializer first
    super(app, "My Application", :width => 1000, :height => 600)

    # Create a horizontal frame to hold the tab book and status bar
    horizontal_frame = FXHorizontalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
	
    # Create a tab book widget
    tab_book = FXTabBook.new(horizontal_frame, :opts => LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # Create the first tab
    tab1 = FXTabItem.new(tab_book, "Tab 1")
	
	#              FXVerticalFrame
	tab1_frame = FXHorizontalFrame.new(tab_book,LAYOUT_FILL_X|LAYOUT_FILL_Y)
	create_filter_area(tab1_frame)
	
	# Create the table in the center
	vframe_table = FXVerticalFrame.new(tab1_frame, :opts => LAYOUT_FILL_X|LAYOUT_FIX_WIDTH)
	vframe_table.width = 620
	table_area = FXGroupBox.new(vframe_table, "Table Area", LAYOUT_FILL_X|LAYOUT_FILL_Y)
	#table_area.width = 620
    @table = FXTable.new(table_area, nil, 0,
      LAYOUT_SIDE_LEFT|LAYOUT_FILL_X|LAYOUT_FIX_HEIGHT|TABLE_READONLY|TABLE_COL_SIZABLE|TABLE_ROW_SIZABLE)
	@table.height =400

    @table.setTableSize(11, 7)
	# Set table header
    @table.setColumnText(0, "Surname")
    @table.setColumnText(1, "Name")
    @table.setColumnText(2, "Lastname")
    @table.setColumnText(3, "Mail")
    @table.setColumnText(4, "Phone")
    @table.setColumnText(5, "Telegram")
    @table.setColumnText(6, "Git")
	 @table.setColumnWidth(6, 200)
	# Add some data to the table
    @data = [
      ["Doe", "John", "Jr.", "johndoe@example.com", "+1234567890", "@johndoe", "github.com/johndoe"],
      ["Smith", "Jane", "A.", "janesmith@example.com", "+0987654321", "@janesmith", "github.com/janesmith"],
      ["Lee", "David", "H.", "davidlee@example.com", "+1111111111", "@davidlee", "github.com/davidlee"],
	  ["Lee", "David", "H.", "davidlee@example.com", "+1111111111", "@davidlee", "github.com/davidlee"],
	  ["Lee", "David", "H.", "davidlee@example.com", "+1111111111", "@davidlee", "github.com/davidlee"],
	  ["Doe", "John", "Jr.", "johndoe@example.com", "+1234567890", "@johndoe", "github.com/johndoe"],
      ["Smith", "Jane", "A.", "janesmith@example.com", "+0987654321", "@janesmith", "github.com/janesmith"],
      ["Lee", "David", "H.", "davidlee@example.com", "+1111111111", "@davidlee", "github.com/davidlee"],
	  ["Lee", "David", "H.", "davidlee@example.com", "+1111111111", "@davidlee", "github.com/davidlee"],
	  ["Lee", "David", "H.", "davidlee@example.com", "+1111111111", "@davidlee", "github.com/davidlee"]

    ]
	
	fill_table(1,2)#TODO Record from input

	# Add buttons for changing pages
	button_layout = FXHorizontalFrame.new(vframe_table,:opts => LAYOUT_FILL_X|LAYOUT_SIDE_BOTTOM)
    prev_button = FXButton.new(button_layout, "Previous",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_LEFT,:padTop=> 10,:padBottom=> 10)
	
    next_button = FXButton.new(button_layout, "Next",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_RIGHT,:padTop=> 10,:padBottom=> 10)
	
    page_label = FXLabel.new(button_layout, "1", :opts => LAYOUT_FIX_X)
    page_label.x = 300
	@total_label = FXLabel.new(button_layout, "Total elements: 0",:opts => LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
	@total_label.x = 20
	@total_label.y = 50
	count_people_lable = FXLabel.new(button_layout, "Count people ",:opts => LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
	count_people_lable.x = 20
	count_people_lable.y = 80
	count_people_input = FXTextField.new(button_layout, 15, :opts => TEXTFIELD_NORMAL|LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
	count_people_input.x = 20
	count_people_input.y = 100
	count_people_input.text = "2"
	@count_people = Integer(count_people_input.text[0]) | 0
	print @count_people 
    prev_button.connect(SEL_COMMAND) do
     # Decrement the current page count and update the UI
      current_page = Integer(page_label.text[0])
      if current_page > 1
        current_page -= 1
        page_label.text = "#{current_page} of #{@total_pages}"
		fill_table(current_page,@count_people)
      end
    end
    next_button.connect(SEL_COMMAND) do
       # Increment the current page count and update the UI
      current_page = Integer(page_label.text[0])
      if current_page < @total_pages
        current_page += 1
        page_label.text = "#{current_page} of #{@total_pages}"
		fill_table(current_page,@count_people)
      end
    end
	 count_people_input.connect(SEL_CHANGED) do
      @count_people = Integer(count_people_input.text[0]) | 0
	  @total_pages = (@table.numRows/@count_people.to_f).ceil
	  page_label.text = "1 of #{@total_pages}"

	  if(@count_people > 0) then
		fill_table(Integer(page_label.text[0]),@count_people)
	  end
    end

	total_rows = @table.numRows
	
	@total_pages = (total_rows / @count_people.to_f).ceil
	page_label.text = "1 of #{@total_pages}"
	@table.rowHeaderWidth = 0
	update_total_label
	
	#print @table.rowHeader
	#@table.connect(SEL_COMMAND) do |sender, selector, data|
	#	@data = @data.sort_by { |row| row[data.col] }
	#	fill_table()
    #end
	header = @table.columnHeader
	header.connect(SEL_COMMAND) do |sender, selector, data|
		print data
		@data = @data.sort_by { |row| row[data] }
		fill_table(Integer(page_label.text[0]),2)
		
    end
	
	# Create the control area on the right
    control_area = FXGroupBox.new(tab1_frame, "Control Area", :opts=> LAYOUT_FIX_WIDTH)
	control_area.width = 200
    FXButton.new(control_area, "Add")
    FXButton.new(control_area, "Edit")
    FXButton.new(control_area, "Delete")
	
    # Create the second tab
    tab2 = FXTabItem.new(tab_book, "Tab 2")

    # Add a label to the second tab
    label2 = FXLabel.new(tab_book, "This is tab 2")
    label2.justify = JUSTIFY_CENTER_X|JUSTIFY_CENTER_Y

    # Create the third tab
    tab3 = FXTabItem.new(tab_book, "Tab 3")

    # Add a label to the third tab
    label3 = FXLabel.new(tab_book, "This is tab 3")
    label3.justify = JUSTIFY_CENTER_X|JUSTIFY_CENTER_Y

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
	
	def update_total_label
		total_elements = @table.numRows * @table.numColumns
		@total_label.text = "Total elements: #{total_elements}"
	end
	
	def create_filter_area(tab1_frame)
		# Create the filtering area on the left
		scroll_window = FXScrollWindow.new(tab1_frame, :opts => LAYOUT_FIX_WIDTH|LAYOUT_FILL_Y|VSCROLLER_ALWAYS)
		scroll_window.width = 180
		filtering_area = FXGroupBox.new(scroll_window, "Filtering Area")
		
		FXLabel.new(filtering_area, "Filter by:")
		FXLabel.new(filtering_area, "Last Name and Initials: ")
		FXTextField.new(filtering_area, 15, :opts => TEXTFIELD_NORMAL)
		
		add_filter(filtering_area,@filter_git,"Наличие гита")
		add_filter(filtering_area,@filter_mail,"Наличие почты")
		add_filter(filtering_area,@filter_mail,"Наличие телеграмма")
		add_filter(filtering_area,@filter_mail,"Наличие телефона")
		
		button_filter = FXHorizontalFrame.new(filtering_area,LAYOUT_FILL_X|LAYOUT_FILL_Y)
		FXButton.new(button_filter, "Обновить")
		FXButton.new(button_filter, "Сбросить")
	end
	
	def add_filter(filtering_area,filter,name_group)

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
	end
	
	def fill_table(num_page,count)
		clear_table()
		@row_per = 0
		ind = 0
		row = 0
		begin_ = count * num_page - count
		if(num_page == 0) then
			begin_ = 0
		end
		@data.each do |row_data|
			column = 0
			if(ind >= begin_ and ind < count*num_page) then
				row_data.each do |cell_data|
					@table.setItemText(row, column, cell_data)
					column += 1
				end
				row +=1
			end
		@row_per += 1
		ind +=1
		end
  end
   def clear_table()
		ind  =0
		row = 0
		
		loop do
			column =0
			loop do
				break if(column > 6)
				@table.setItemText(row, column, "")
				column+=1
			end 
			break if row >@data.length-1 
			row +=1
		end
		#print @table.columnHeader
   end
  
end

# Start the application
application = FXApp.new
main_window = MyMainWindow.new(application)
application.create
main_window.show(PLACEMENT_SCREEN)
application.run
