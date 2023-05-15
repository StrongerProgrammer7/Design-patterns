require_relative '../../model_entity/list_file/entities_list_from_file.rb'

class Persons_list_txt < Entities_list_from_file
	
	def initialize()
		@person = person
	end
	
	def read_from_file(addressFile)
		addressFile = File.dirname($0) + "/../../#{@person.addressFile}"  if addressFile==nil #Fot test
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		persons = Array.new()
		File.open(addressFile,'r') do |file|
			file.each_line do |line|
				persons.push(@person.get_person(line.delete "\n")) if(line!="")
			end
		end
		persons
	end

	def write_to_file(addressFile,nameFile,persons)
		file = File.new("#{addressFile}/#{nameFile}","w:UTF-8")
		persons.each do |i|
			file.print(@person.create_line_person(i))
		end
		file.close
	end

end