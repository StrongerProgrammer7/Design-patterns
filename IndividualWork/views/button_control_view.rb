
require 'fox16'

include Fox

class Button_control
	def initialize(tab_frame,width:200)
		@control_area = FXGroupBox.new(tab_frame, "Control Area", :opts=> LAYOUT_FIX_WIDTH)
		@control_area.width = 200
	end
	
	def createButton(name)
		FXButton.new(@control_area, name)
	end
end
