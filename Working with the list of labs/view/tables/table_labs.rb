
require_relative File.dirname($0) + '/tables.rb'
require 'fox16'

include Fox

class Table_lab_works < Table
	
	def initialize(tab_frame,name_table)
		super(tab_frame,name_table,width_frame:820,table_height:450)
		create_button_change_page()
	end
	
	private 

	def create_button_change_page()
		if(self.num_current_page==nil) then
			# Add buttons for changing pages
			button_layout = FXHorizontalFrame.new(self.vframe_table,:opts => LAYOUT_FILL_X|LAYOUT_SIDE_BOTTOM)		

			display_numPage_countPage(button_layout,pos_x:400)
			
		else
			self.num_current_page.text = "1 of #{@total_pages}"
		end
	
	end

	def display_numPage_countPage(button_layout,pos_x:300)
		self.num_current_page = FXLabel.new(button_layout, "1", :opts => LAYOUT_FIX_X)
		self.num_current_page.x = pos_x


		#whole_entites_count_label = FXLabel.new(button_layout, "Count labs ",:opts => LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		#whole_entites_count_label.x = 20
		#whole_entites_count_label.y = 80
	
		@total_pages =1 
		self.num_current_page.text = "1 of #{@total_pages}"
	end

end