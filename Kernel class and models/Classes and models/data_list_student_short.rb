load './data_list.rb'
load './datatable.rb'

class Data_list_student_short < Data_list
	private
		def get_names(dataGrid)
			names_attribue = []
			dataGrid.each { |i| if(i!=0) then names_attribue.push(i.HeaderText) end}
			return names_attribue
		end
	
		def get_data(entities)
			new Data_table(entities)
		end
end