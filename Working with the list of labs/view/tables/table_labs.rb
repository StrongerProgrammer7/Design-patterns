
require_relative File.dirname($0) + '/tables.rb'
require 'fox16'

include Fox

class Table_lab_works < Table
	
	def initialize(tab_frame,name_table)
		super(tab_frame,name_table,width_frame:820,table_height:600)
		
	end

end