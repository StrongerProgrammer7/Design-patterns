require_relative '../../model_entity/Datatable/data_list.rb'

class Data_list_labs < Data_list

	attr_accessor :student_list_view #observer model

	def notify(whole_entities_count)
		self.student_list_view.set_table_params(get_names(),whole_entities_count)
		self.student_list_view.set_table_data(self.get_data())
	end

	private
		def get_names()
			arr_attr= ["num","name","topics","tasks","date_of_issue"] 
		end
	
		def get_data()
			matrix = []
			@list_entities.each  do |elem|
				matrix.push([elem.number,elem.name,elem.topics,elem.tasks,elem.date,elem.id])
			end
			matrix
		end

end