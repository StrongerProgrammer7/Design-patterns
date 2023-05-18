require_relative '../../model_entity/Datatable/data_list.rb'

class Data_list_auto < Data_list

	attr_accessor :observer #observer model

	def notify(whole_entities_count)
		self.observer.set_table_params(get_names(),whole_entities_count)
		self.observer.set_table_data(self.get_data())
	end

	private
		def get_names()
			arr_attr= ["num","surname_owner","model","mark","color"] 
		end
	
		def get_data()
			matrix = []
			count = 1
			@list_entities.each  do |elem|
				matrix.push([count,elem.surname_owner,elem.model,elem.mark,elem.color,elem.id,elem.id_owner])
				count +=1
			end
			matrix
		end

end