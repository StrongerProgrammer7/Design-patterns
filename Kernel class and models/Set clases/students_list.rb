load './data_list.rb'
load './student_short.rb'
load './students_list_file.rb'
load './students_list_txt.rb'
load './students_list_json.rb'
load './students_list_yaml.rb'

class Students_list
	attr_writer :format_file
	attr_reader :list_students

	def initialize(format_file)
		self.format_file = format_file 
	end

	def get_student_by_id(id)
		self.list_students.each do |elem|
			if(elem.id == id) then
				return elem
			end
		end
		return nil
	end

	def get_k_n_student_short_list(k,n,data_list:nil)
		list_students_short = []
		index_elem = 0
		index_list = 0
		self.list_students.each do |elem|
			if(index_elem == n && index_list < k) then
				index_list = index_list + 1
				index_elem = 0
			end
			if(index_list == k && index_elem <= n) then
				list_students_short.push(Student_short.initialization(elem))
				if(index_elem == n)
					break
				end	
			end
			index_elem = index_elem + 1		
		end


		if(data_list == nil) then
			return Data_list.new(list_students_short)
		else
			return data_list.list_entities = list_students_short
		end
	end

	def sort_by_initials(data_list)
		data_list.list_entities.sort! { |a,b| a.initials <=> b.initials}
	end

	def push_student(student)
		id = self.list_students,max_by { |elem| elem.id }.id
		student.id = id
		self.list_students.push(student)
	end

	def replace_element_by_id(id,element)
		self.list_students.map! { |elem| elem.id = id ? element : elem }
	end

	def delete_element_by_id(id)
		self.list_students.delete_if { |elem| elem.id == id }
	end

	def get_student_short_count()
		self.list_students.length
	end

	def read_from_file(addressFile)
		self.list_students = self.format_file.read_from_file(addressFile)
	end 

	def write_to_file(addressFile,nameFile,students)
		self.format_file.write_to_file(addressFile,nameFile,students)
	end 

	private
		attr_writer :list_students
		attr_reader :format_file

end