require_relative File.dirname($0) + '/data_list.rb'
require_relative File.dirname($0) + './persons/student_short.rb'
require_relative File.dirname($0) + './list_file/students_list_file.rb'
require_relative File.dirname($0) + './list_file/students_list_txt.rb'
require_relative File.dirname($0) + './list_file/students_list_json.rb'
require_relative File.dirname($0) + './list_file/students_list_yaml.rb'


class Sutdents_list_DB
	attr_reader :list_students

	def initialize(list_students)
		self.list_students = list_students
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

	private
	attr_writer :list_students

end