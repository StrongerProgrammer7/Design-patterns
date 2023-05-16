require_relative '../../model_entity/Datatable/data_list.rb'

class Data_list_person_short < Data_list

	attr_accessor :observer #observer model

	def notify(whole_entities_count)
		self.observer.set_table_params(get_names(),whole_entities_count)
		self.observer.set_table_data(self.get_data())
	end

	private
		def get_names()
			["num","initials","contact","mail"] 
		end
	
		def get_data()
			countRecords = 1
			matrix = []
			@list_entities.each  do |elem|
				matrix.push([countRecords,elem.initials,elem.contact,elem.mail,elem.id])
				countRecords = countRecords + 1
			end
			matrix	
		end

end