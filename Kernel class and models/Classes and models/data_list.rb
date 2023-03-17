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

	def fillData()
		names_attributies = get_names()
		data_entity = get_data()
	end

private
	attr_writer :array_objects		

	def get_names()
	end

	def get_data()
	end
end