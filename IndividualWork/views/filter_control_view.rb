require 'fox16'

include Fox

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