load './data_list.rb'
load './student.rb'
load './student_short.rb'
require 'json'


class Students_list_json
	def initialize(addressFile)
		list_students = read_from_json(addressFile)
	end

	def get_student_by_id(id)
		list_students.each do |elem|
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
		list_students.each do |elem|
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
		id = list_students,max_by { |elem| elem.id }.id
		student.id = id
		list_students.push(student)
	end

	def replace_element_by_id(id,element)
		list_students.map! { |elem| elem.id = id ? element : elem }
	end

	def delete_element_by_id(id)
		list_students.delete_if { |elem| elem.id == id }
	end

	def get_student_short_count()
		list_students.length
	end

	def read_from_json(addressFile)
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		students = Array.new()
		File.open(addressFile,'r') do |file|
			file.each_line do |line|
				print JSON.parse(line)
		#		students.push(Student.initialization(line.delete "\n")) if(line!="")
			end
		end
		#students =JSON.parse(File.read('addressFile',encoding: 'utf-8'))
	end

	def write_to_json(addressFile,nameFile,students)
		file = File.new("#{addressFile}/#{nameFile}","w:UTF-8")
		students.each do |i|
			file.print("#{i.to_s()},#{i.get_all_contacts()},#{i.git}\n")
		end
		file.close
	end

	private
		attr_accessor :list_students
end