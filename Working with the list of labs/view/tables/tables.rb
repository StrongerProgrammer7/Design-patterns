
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

	def get_data()
		self.data
	end

	private
		attr_writer :num_current_page
		attr_accessor :data, :vframe_table, :whole_entites_count

	def fill_table(num_page,count,filter_git:nil,filter_mail:nil,filter_telegram:nil,filter_phone:nil,	filter_surname_initials:nil)
		raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
	end




end

=begin
require 'date'

date_string = '15.05.2022'
date = Date.strptime(date_string, '%d.%m.%Y')
milliseconds = date.strftime('%Q').to_i

puts milliseconds

=end