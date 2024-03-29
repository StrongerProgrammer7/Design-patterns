require_relative '../../model_entity/Datatable/data_list.rb'

class Data_list_mark < Data_list

	attr_accessor :observer #observer model

	def notify(whole_entities_count)
		self.observer.set_table_params(get_names(),whole_entities_count)
		self.observer.set_table_data(self.get_data())
	end

	private
		def get_names()
			["mark"] 
		end
	
		def get_data()
			matrix = []
			@list_entities.each  do |elem|
				matrix.push([elem.mark])
			end
			matrix
		end

end