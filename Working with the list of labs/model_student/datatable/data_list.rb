require_relative File.dirname($0) + '/datatable.rb'

class Data_list
	attr_writer :list_entities

	def initialize(entities)
		self.list_entities = entities
		@selected = []
	end

	def select(number)
		@selected << number.to_i
	end

	def get_selected()
		res = []
		@selected.each {|elem| res << @list_entities[elem.to_i - 1].id}
		@selected = []
		res
	end
	#Accept pattern "Template"
	def getDataFromTable()
		names_attributes = get_names()
		matrix = get_data().unshift(names_attributes)
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