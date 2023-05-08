require_relative File.dirname($0) + './persons/student.rb'
require_relative File.dirname($0)+ '/students_list_file.rb'

require 'json'


class Students_list_json < Students_list_from_file
	
	def read_from_file(addressFile)
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		
		students = Array.new()
		file = File.read addressFile
		students_hash = JSON.parse(file)

		students_hash.each do |key, student|
			line = ""
			student.each do |key_fields, elem|
				line+= elem.to_s + "," if(elem!=nil)
			end
			line.delete_suffix! ","
			students.push(Student.initialization(line)) if(line!="")
		end		
		students
	end

	def write_to_file(addressFile,nameFile,students)
		file = File.new("#{File.dirname($0)}#{addressFile}/#{nameFile}.json","w:UTF-8")
		student_hash = {}
		number_student = 1
		students.each do |i|
			student_hash["student#{number_student}"] = {
				"id"=>i.id,
				"surname"=>i.surname,
				"name"=>i.name,
				"lastname"=>i.lastname,
				"phone"=>i.phone,
				"mail"=>i.mail,
				"telegram"=>i.telegram,
				"git" => i.git
			}
			number_student+=1
		end
		file.write(JSON.pretty_generate(student_hash))
		file.close
	end

end