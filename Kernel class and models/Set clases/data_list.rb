load ('./datatable.rb')

class Data_list
	attr_writer :list_entities

	def initialize(entities)
		self.list_entities = entities
		@selected = []
	end

	def select(number)
		@selected << number
	end

	def get_selected()
		res = []
		@selected.each {|elem| res << @list_entities[elem].id}
		res
	end
	#Accep pattern "Template"
	def getDataFromTable()
		names_attribue = get_names()
		matrix = get_data().unshift(names_attribue)
		res = Data_table.new(matrix)
	end

private
	attr_reader :list_entities

	def get_names()
		raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
	end

	def get_data()
		raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
	end
	
end