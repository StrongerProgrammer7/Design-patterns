load './student.rb'
load './students_list_file.rb'

class Students_list_txt < Students_list_from_file
	#plесь потом будет объект 
	# Абстрактный класс который будет содержать методы reaad and write file
	# Наследники от абстр реализ json yaml txt

	def initialize(addressFile)
		#на вход придет объект который запишется , объект абстрактного класса Studetn_file (придет наследник)
		list_students = read_from_txt(addressFile)
	end

	#реализовать сет объекта абстрак класса Student_file
	

	def read_from_txt(addressFile)
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		students = Array.new()
		File.open(addressFile,'r') do |file|
			file.each_line do |line|
				students.push(Student.initialization(line.delete "\n")) if(line!="")
			end
		end
		students
	end

	def write_to_txt(addressFile,nameFile,students)
		file = File.new("#{addressFile}/#{nameFile}","w:UTF-8")
		students.each do |i|
			file.print("#{i.to_s()},#{i.get_all_contacts()},#{i.git}\n")
		end
		file.close
	end

end