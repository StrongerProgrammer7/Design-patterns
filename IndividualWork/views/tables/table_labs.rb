
require_relative File.dirname($0) + '/tables.rb'
require 'fox16'

include Fox

class Table_lab_works < Table
	
	def initialize(tab_frame,name_table)
		super(tab_frame,name_table,width_frame:820,table_height:450)
	end
	
	 

	def create_button_change_page()
		if(self.num_current_page==nil) then
			# Add buttons for changing pages
			button_layout = FXHorizontalFrame.new(self.vframe_table,:opts => LAYOUT_FILL_X|LAYOUT_SIDE_BOTTOM)		

			display_numPage_countPage(button_layout,pos_x:400)
			
		else
			self.num_current_page.text = "1 of #{@total_pages}"
		end
	
	end

	private

	def display_numPage_countPage(button_layout,pos_x:300)
		self.num_current_page = FXLabel.new(button_layout, "1", :opts => LAYOUT_FIX_X)
		self.num_current_page.x = pos_x
	
		@total_pages =1 
		self.num_current_page.text = "1 of #{@total_pages}"
	end

	def fill_table(num_page,count,filter_git:nil,filter_mail:nil,filter_telegram:nil,filter_phone:nil,
	filter_surname_initials:nil)
		clear_table((self.data[0].length-1),(self.data.length - 1))
		row = 0
		begin_ = if num_page != 0 then count * num_page - count else 0 end
		ind = begin_
		loop do 
			row = fill_table_rows(ind,row)
			ind +=1
			if(ind >= count * num_page) then 
				break 
			end
		end
   end 


   def fill_table_rows(ind,row)
   		fillRow(self.data[ind],row,5)
		row +=1	
   end
end