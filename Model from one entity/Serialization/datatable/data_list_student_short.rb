require_relative File.dirname($0) + '/data_list.rb'

class Data_list_student_short < Data_list
	private
		def get_names()
			arr_attr= ["id","initials","contact","git"] 
		end
	
		def get_data()
			countRecords = 0
			matrix = []
			@list_entities.each  do |elem|
				matrix.push([countRecords,elem.initials,elem.contact,elem.git])
				countRecords = countRecords + 1
			end
			matrix	
		end

end