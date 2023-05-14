require_relative File.dirname($0) + './persons/student.rb'
require_relative '../../model_entity/list_file/students_list_file.rb'

class Students_list_txt < Students_list_from_file
	
	#--------------------Test dev - Students ------------------------
	attr_accessor :addressFile 
	def initialize()
		self.addressFile = "./testfile/test.txt"
	end
	#----------------------------------------------------

	def read_from_file(addressFile)
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		students = Array.new()
		File.open(addressFile,'r') do |file|
			file.each_line do |line|
				students.push(Student.initialization(line.delete "\n")) if(line!="")
			end
		end
		students
	end

	def write_to_file(addressFile,nameFile,students)
		file = File.new("#{addressFile}/#{nameFile}","w:UTF-8")
		students.each do |i|
			file.print("#{i.id},#{i.to_s()},#{i.get_all_contacts()},#{i.git}\n")
		end
		file.close
	end

end