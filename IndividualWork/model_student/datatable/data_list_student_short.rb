require_relative '../../model_entity/Datatable/data_list.rb'

class Data_list_student_short < Data_list

	attr_accessor :student_list_view #observer model

	def notify(whole_entities_count)
		self.student_list_view.set_table_params(get_names(),whole_entities_count)
		self.student_list_view.set_table_data(self.get_data())
	end

	private
		def get_names()
			arr_attr= ["num","initials","contact","git"] 
		end
	
		def get_data()
			countRecords = 1
			matrix = []
			@list_entities.each  do |elem|
				matrix.push([countRecords,elem.initials,elem.contact,elem.git,elem.id])
				countRecords = countRecords + 1
			end
			matrix	
		end

end