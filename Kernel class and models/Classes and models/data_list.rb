class Data_list
	attr_reader :array_objects
	
	def initialize()
		self.array_objects = Array.new() { }
	end

	def select(number)
		self.array_objects[number]
	end

	def get_selected(arr_selected_elements)
		selectedElem = []
		arr_selected_elements.each do |elem|
			index = elem[0]
			object = select(index)
			selectedElem.push(object.id)
		end
		return selectedElem
	end

	def getDataFromTable(dataGrid,entity)
		names_attributies = get_names(dataGrid)
		data_entity = get_data(entity)
	end


private
	attr_writer :array_objects		
	def get_names(dataGrid)
		raise NotImplementedError, "#{self.class} has not implemented mathod '#{__method__}'"
	end

	def get_data(entity)
		raise NotImplementedError, "#{self.class} has not implemented mathod '#{__method__}'"
	end
	
end