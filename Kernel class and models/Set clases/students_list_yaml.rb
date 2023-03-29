load './students_list_file.rb'
load './student.rb'

require 'yaml'


class Students_list_yaml < Students_list_from_file

	def initialize(addressFile)
		list_students = read_from_yaml(addressFile)
	end

	def read_from_yaml(addressFile)
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		
		students = Array.new()
		students_hash = YAML.load_file(addressFile)
		students_hash.each do |key, student|
			line = ""
			student.each do |key_fields, elem|
				line+= elem + "," if(elem!=nil)
			end
			line.delete_suffix! ","
			students.push(Student.initialization(line)) if(line!="")
		end		
		students
	end

	def write_to_yaml(addressFile,nameFile,students)
		file = File.new("#{addressFile}/#{nameFile}.yaml","w:UTF-8")
		student_hash = {}
		number_student = 1
		students.each do |i|
			student_hash["student#{number_student}"] = {
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
		file.write(student_hash.to_yaml)
		file.close
	end

end