class Data_list
	attr_reader :set_object
	
	def initialize()
		self.set_object = Array.new() { }
	end

	def select(number)
		self.set_object[number]
	end

	def get_selected(arr_seleected_elements)

	end

	def fillData()
		names_attributies = get_names()
		data_entity = get_data()
	end

private
	attr_writer :set_object		

	def get_names()
	end

	def get_data()
	end
end