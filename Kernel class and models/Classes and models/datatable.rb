

class Data_table
	def initialize(entities)
		array_temp = []
		entities.each do |entity| 
				array_temp.push(@@countRecords)
				@@countRecords = @@countRecords + 1
				array_temp.push(entity.surname,entity.name,entity.lastname,entity.phone,entity.mail,entity.telegram,entity.git)
				self.set_attr_entities.push(array_temp)
				array_temp.clear
			end
		end
		# self.set_attr_entities.push(
		#	[@@countRecords,entity.surname,entity.name,entity.lastname,entity.phone
		#	,entity.mail,entity.telegram,entity.git])
		#@@countRecords = @@countRecords + 1
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
		@@countRecords = 0
end