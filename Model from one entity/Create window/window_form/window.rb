require 'fox16'

include Fox

class MyMainWindow < FXMainWindow
  def initialize(app)
    # Call the base class initializer first
    super(app, "My Application", :width => 1000, :height => 800)

    # Create a horizontal frame to hold the tab book and status bar
    horizontal_frame = FXHorizontalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
	
    # Create a tab book widget
    tab_book = FXTabBook.new(horizontal_frame, :opts => LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # Create the first tab
    tab1 = FXTabItem.new(tab_book, "Tab 1")
	
	#FXVerticalFrame
	tab1_frame = FXHorizontalFrame.new(tab_book, LAYOUT_FILL_X|LAYOUT_FILL_Y)
	 # Create the filtering area on the left
    filtering_area = FXGroupBox.new(tab1_frame, "Filtering Area")
    FXLabel.new(filtering_area, "Filter by:")
	FXLabel.new(filtering_area, "Last Name and Initials: ")
    FXTextField.new(filtering_area, 15, :opts => TEXTFIELD_NORMAL)
	
	# Add a radio button group or a combo box widget to part 2 for selecting presence or absence of git
	@filter_git = FXDataTarget.new(2)
	git_group = FXGroupBox.new(filtering_area, "Наличие Гита", :opts => GROUPBOX_NORMAL|GROUPBOX_TITLE_LEFT|FRAME_GROOVE|LAYOUT_SIDE_TOP)
    git_yes = FXRadioButton.new(git_group, "Есть",:target => @filter_git, :selector => FXDataTarget::ID_OPTION)
    git_no = FXRadioButton.new(git_group, "Нет",:target => @filter_git, :selector => FXDataTarget::ID_OPTION+1)
    git_dontcare = FXRadioButton.new(git_group, "Не важно",:target => @filter_git, :selector => FXDataTarget::ID_OPTION+2)
 	
	# Add a text field widget to part 2 for entering text to search on the git
    search_label = FXLabel.new(filtering_area, "Search: ")
    search_field = FXTextField.new(filtering_area, 15, :opts => TEXTFIELD_NORMAL|TEXTFIELD_READONLY)
    search_field.disable
	
	@filter_git.connect(SEL_COMMAND) do
		puts "The newly selected value is #{@filter_git.value}"
		search_field.enable if @filter_git.value == 0
		search_field.disable if @filter_git.value >0 
	end
	
	
	№FXButton.new(filtering_area, "Apply")
    №FXButton.new(filtering_area, "Reset")
	# Create the table in the center
    table = FXTable.new(tab1_frame, nil, 0,
      LAYOUT_SIDE_LEFT|LAYOUT_FILL_X|LAYOUT_FILL_Y|LAYOUT_FILL_ROW)
	table.visibleRows = 5
    table.visibleColumns = 7
    table.setTableSize(15, 8)
	
	#table.setColumnText(0, "Ruby 1.8.6")
	#table.rowHeaderMode = LAYOUT_FIX_WIDTH
	#table.rowHeaderWidth = 0
	#table.columnHeaderMode = LAYOUT_FIX_HEIGHT
	
	# Create the control area on the right
    control_area = FXGroupBox.new(tab1_frame, "Control Area")
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
end

# Start the application
application = FXApp.new
main_window = MyMainWindow.new(application)
application.create
main_window.show(PLACEMENT_SCREEN)
application.run
