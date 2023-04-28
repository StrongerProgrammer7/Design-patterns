require 'fox16'
include Fox

=begin
application = FXApp.new("Hi","Ruby")
main = FXMainWindow.new(application,"Hi",nil,nil,DECOR_ALL)
application.create()
main.show(PLACEMENT_SCREEN)
application.run()
=end

class MyMainWindow < FXMainWindow
  def initialize(app)
    # Call the base class initializer first
    super(app, "My Application", :width => 400, :height => 300)

    # Create a horizontal frame to hold the tab book and status bar
    horizontal_frame = FXHorizontalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # Create a tab book widget
    tab_book = FXTabBook.new(horizontal_frame, :opts => LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # Create the first tab
    tab1 = FXTabItem.new(tab_book, "Tab 1")

    # Add a label to the first tab
    label1 = FXLabel.new(tab_book, "This is tab 1")
    label1.justify = JUSTIFY_CENTER_X|JUSTIFY_CENTER_Y

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
