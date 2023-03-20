

class Data_table
	def initialize(entities)
		self.set_attr_entities = []
		entities.each do |entity| 
			self.set_attr_entities.push(entity)
		end
		print self.set_attr_entities,"\n"
	end

	def get_element(row,column)
		self.set_attr_entities[row][column]
	end
	def get_countColumn
		self.set_attr_entities[1].count
	end

	def get_countRow
		self.set_attr_entities.count
	end
	private
		attr_accessor :set_attr_entities
		
end