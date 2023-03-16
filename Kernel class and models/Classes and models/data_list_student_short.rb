load './data_list.rb'
load './datatable.rb'

class Data_list_student_short < Data_list
	def get_names(dataGridColumns)
		names_attribue = []
		dataGridColumns.each { |i| if(i!=0) then names_attribue.push(i.HeaderText) end}
		return names_attribue
	end

	def get_data(entity)
		new Data_table(entity)
	end
end