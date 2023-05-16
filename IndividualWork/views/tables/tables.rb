
require 'fox16'

include Fox

class Table

	attr_accessor :table, :count_data
	attr_reader :data, :vframe_table, :whole_entites_count, :num_current_page

	def initialize(tab_frame,name_table, width_frame:620,table_height:400)
		self.vframe_table = FXVerticalFrame.new(tab_frame, :opts => LAYOUT_FILL_X|LAYOUT_FIX_WIDTH)
		self.vframe_table.width = width_frame
		
		table_area = FXGroupBox.new(self.vframe_table, name_table, LAYOUT_FILL_X|LAYOUT_FILL_Y)
		
		self.table = FXTable.new(table_area, nil, 0,
		LAYOUT_SIDE_LEFT|LAYOUT_FILL_X|LAYOUT_FIX_HEIGHT|TABLE_READONLY|TABLE_COL_SIZABLE|TABLE_ROW_SIZABLE)
		self.table.height = table_height
		
		self.table.rowHeaderWidth = 40

	end

	def set_table_params(column_names,whole_entites_count)
		self.whole_entites_count = whole_entites_count
		self.table.setTableSize(whole_entites_count,column_names.length)
		setHeaderText(column_names)
		#print (self.table.numColumns)
	end

	def set_table_data(data_table)
		self.data = data_table
		self.count_data = self.data.length
		fill_table(1,self.whole_entites_count) 
		#print (self.table.numRows)
	end

	private
		attr_writer :num_current_page, :data
		attr_accessor :vframe_table, :whole_entites_count

	def fill_table(num_page,count,filter_mail:nil,filter_phone:nil,	filter_surname_initials:nil)
		raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
	end

	def setHeaderText(column_names)
		num = 0
		@columns_size = Array.new(column_names.length) { |i| i =0 }
		column_names.each do |name|
			self.table.setColumnText(num, name) if num < column_names.length
			num+=1
		end
		self.table.setColumnWidth((0), 40)
	end

	def clear_table(count_col,count_row)
		row = 0		
		loop do
			column =0
			loop do
				break if(column > count_col - 1)
				self.table.setRowText(row,"")
				self.table.setItemText(row, column, "")
				column+=1
			end 
			break if row > count_row - 1
			row +=1
		end
   end

    def fillRow(row_data,row,max_column)
   		column = 0
   		if(row_data!=nil) then
   			row_data.each do |cell_data|
				self.table.setItemText(row, column, cell_data.to_s)  if(column<max_column)
				column += 1
			end
			self.table.setRowText(row,(row_data[row_data.length-1]).to_s)
		end		
   end

end

