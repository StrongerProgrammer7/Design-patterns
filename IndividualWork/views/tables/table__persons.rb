
require_relative File.dirname($0) + '/tables.rb'
require 'fox16'

include Fox

class Table_persons < Table
	attr_accessor :current_data, :prev_data_button,:next_data_button, :label_num_current_page_data
	
	def initialize(tab_frame,name_table)
		super(tab_frame,name_table)

		@button_layout = FXHorizontalFrame.new(self.vframe_table,:opts => LAYOUT_FILL_X|LAYOUT_SIDE_BOTTOM)

		self.table.columnHeader.connect(SEL_COMMAND) do |sender, selector, data|
			current_page = self.num_current_page.text.slice(0,self.num_current_page.text.index(" "))
			if(self.current_data != nil && self.current_data.length != 0) then
				if(self.chekbox_sort_all_data_toTable.checked?) then
					self.data = self.data.sort_by { |row| row[data] if row[data]!=nil or row[data]!='' }
					fill_table(Integer(current_page),self.whole_entites_count)
				else
					self.current_data = self.current_data.sort_by { |row| row[data] if row[data]!=nil or row[data]!='' }
					fill_table_sort_data(Integer(current_page),self.whole_entites_count,self.current_data)
				end
				
			end		
		end
		
	end

	
	def filter_data(filter_mail:nil,filter_phone:nil,filter_surname_initials:nil)
		fill_table(1,self.whole_entites_count,filter_mail:filter_mail,filter_phone:filter_phone,filter_surname_initials:filter_surname_initials)
	end

	def create_button_change_page()
		if(self.num_current_page==nil) then
			create_btn_change_data()
						
			list_btn = create_btn_change_page()
			display_numPage_countPage()			
			event_btn_change_page(list_btn[0],list_btn[1])
			
		else
			@whole_entites_count_input.text = self.whole_entites_count.to_s
			@total_pages = (self.table.numRows/self.whole_entites_count.to_f).ceil
			self.num_current_page.text = "1 of #{@total_pages}"
		end
	
	end

	def delete_person_from_data(num)
		self.data.delete_at(num)
		self.current_data.delete_at(num)
		self.table.removeRows(num)
	end
	
	private
		attr_accessor :chekbox_sort_all_data_toTable


  def fill_table(num_page,count,filter_mail:nil,filter_phone:nil,filter_surname_initials:nil)
		clear_table((self.data[0].length-1),(self.data.length - 1))
		row = 0
		begin_ = if num_page != 0 then count * num_page - count else 0 end
		ind = begin_
		self.current_data = []
		loop do 
			if(self.data[ind]!=nil) then
				row = fill_table_rows(ind,row,filter_surname_initials:filter_surname_initials,filter_phone:filter_phone)
			end
			if(ind >= (count * num_page)-1) then 
				break 
			end
			ind +=1
		end
   end 


   def fill_table_rows(ind,row,filter_surname_initials:nil,filter_phone:nil)
   	if(filter_surname_initials!=nil) then
			row = fill_table_by_filter_initials(row,ind,filter_surname_initials)
		elsif (filter_phone != nil) then
			row = fill_table_by_filter_phone(row,ind,filter_phone)
		else
			fillRow(self.data[ind],row,4)
			row +=1	
		end
		row
   end

   def fill_table_by_filter_initials(row,ind,filter_surname_initials)
   	if self.data[ind][1].include? filter_surname_initials then
			fillRow(self.data[ind],row,4) 
			return row +=1
		end
		row
   end

   def fill_table_by_filter_phone(row,ind,filter_phone)
   	if self.data[ind][2].include? filter_phone then
   		if filter_phone.length == 1 && filter_phone[0] == '8' then
   			fillRow(self.data[ind],row,4) if self.data[ind][2][1] == '8'
   			return row +=1 if self.data[ind][2][1] == '8'
   		else
				fillRow(self.data[ind],row,4)
				return row +=1
			end
		end
		row
   end

   def fillRow(row_data,row,max_column)
   	super(row_data,row,max_column)
		self.current_data << row_data  if row_data != nil		
   end
  

#---------------------------------TODO--REFACTORING!!
   def fill_table_sort_data(num_page,count,data)
   		row = 0
			begin_ = if num_page != 0 then count * num_page - count else 0 end
			ind = 0
		loop do 
			fill_row_sort_data(data[ind],row)
			ind +=1
			row +=1
			if(ind >= count * num_page) then 
				break 
			end
		end
   end

   def fill_row_sort_data(row_data,row)
   	column = 0
   		if(row_data!=nil) then
   			row_data.each do |cell_data|
						self.table.setItemText(row, column, cell_data.to_s) if (column < 4)
						column += 1
				end
			self.table.setRowText(row,(row_data[row_data.length-1]).to_s)
		end
 	 end
#---------------------------------------------   

   def display_numPage_countPage(pos_x:300)
		self.num_current_page = FXLabel.new(@button_layout, "1", :opts => LAYOUT_FIX_X)
		self.num_current_page.x = pos_x

		whole_entities_count_label_create()
	
		create_whole_entites_count_input()

		create_chekbox_sort_all_data_in_table()
		
		event_whole_entites_count_changed()
						
		@total_pages = 1
		self.num_current_page.text = "1 of #{@total_pages}"
		create_label_num_current_page(pos_x)
	end

	def create_btn_change_data()
		self.prev_data_button = FXButton.new(@button_layout, "Previous data",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_LEFT,:padTop=> 10,:padBottom=> 10)
		self.next_data_button = FXButton.new(@button_layout, "Next data",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_RIGHT,:padTop=> 10,:padBottom=> 10)
	end

	def create_btn_change_page()
		prev_button = FXButton.new(@button_layout, "Previous page",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_LEFT,:padTop=> 10,:padBottom=> 10)
		next_button = FXButton.new(@button_layout, "Next page",:opts => FRAME_RAISED|FRAME_THICK|BUTTON_NORMAL|LAYOUT_RIGHT,:padTop=> 10,:padBottom=> 10)
		[prev_button,next_button]
	end

	def event_btn_change_page(prev_button,next_button)
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

	def whole_entities_count_label_create()
		whole_entites_count_label = FXLabel.new(@button_layout, "Count people ",:opts => LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		whole_entites_count_label.x = 20
		whole_entites_count_label.y = 80
	end

	def create_chekbox_sort_all_data_in_table()
		self.chekbox_sort_all_data_toTable = FXCheckButton.new(@button_layout, " Sort all data in the table", :opts => LAYOUT_FIX_X|LAYOUT_FIX_Y|LAYOUT_SIDE_BOTTOM)

		self.chekbox_sort_all_data_toTable.x = 160
		self.chekbox_sort_all_data_toTable.y = 100
	end

	def create_label_num_current_page(pos_x)
		self.label_num_current_page_data = FXLabel.new(@button_layout, "",:opts => LAYOUT_FIX_X|LAYOUT_FIX_Y|LAYOUT_SIDE_BOTTOM)
		self.label_num_current_page_data.x = pos_x - 25
		self.label_num_current_page_data.y = 25
		self.label_num_current_page_data.text = "1 page of Max data"
	end

	def create_whole_entites_count_input()
		@whole_entites_count_input = FXTextField.new(@button_layout, 15, :opts => TEXTFIELD_NORMAL|LAYOUT_FIX_X|LAYOUT_SIDE_BOTTOM|LAYOUT_FIX_Y)
		@whole_entites_count_input.x = 20
		@whole_entites_count_input.y = 100
		@whole_entites_count_input.text = self.whole_entites_count.to_s
	end

	def event_whole_entites_count_changed()
		@whole_entites_count_input.connect(SEL_CHANGED) do
			if @whole_entites_count_input.text!=nil and  @whole_entites_count_input.text != "" and @whole_entites_count_input.text!='0' then
				if /^[0-9]*$/.match(@whole_entites_count_input.text)!=nil then
					self.whole_entites_count = Integer(@whole_entites_count_input.text)
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
	end
end