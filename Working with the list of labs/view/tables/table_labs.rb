
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


		#whole_entites_count_label = FXLabel.new(button_layout, "Count labs ",:opts => LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		#whole_entites_count_label.x = 20
		#whole_entites_count_label.y = 80
	
		@total_pages =1 
		self.num_current_page.text = "1 of #{@total_pages}"
	end

	def setHeaderText(column_names)
		num = 0
		column_names.each do |name|
			self.table.setColumnText(num, name) if num < column_names.length
			num+=1
		end
		self.table.setColumnWidth((0), 40)
		self.table.setColumnWidth((column_names.length-1), 200)
	end


	def fill_table(num_page,count,filter_git:nil,filter_mail:nil,filter_telegram:nil,filter_phone:nil,
	filter_surname_initials:nil)
		#clear_table((self.data[0].length-1),(self.data.length - 1))
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
   		fillRow(self.data[ind],row)
		row +=1	
		row
   end

   def fillRow(row_data,row)
   	column = 0
   	if(row_data!=nil) then
   		row_data.each do |cell_data|
					self.table.setItemText(row, column, cell_data.to_s) if(column<5)
					column += 1
			end
			self.table.setRowText(row,(row_data[row_data.length-1]).to_s)
			#self.current_data << row_data
		end		
   end


end