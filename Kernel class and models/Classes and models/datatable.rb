

class Data_table
	def initialize(entity)
		self.set_attr_entities.push([entity.id,entity.surname,entity.name,entity.lastname,entity.phone
			,entity.mail,entity.telegram,entity.git])
	end

	def get_element(row,column)
		self.set_attr_entities[rows][column]
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