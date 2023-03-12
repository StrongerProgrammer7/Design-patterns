class Data_list
	attr_reader :set_object
	
	def initialize()
		self.set_object = Array.new() { }
	end

	def select(number)
		self.set_object(number)
	end

	def get_names()
	end

	def get_data()
		#0 column is generic numb in sequence
		#other column get all attribute entity without id
		#realise in heirs
	end

	private
		attr_writer :set_object		
end