require_relative File.dirname($0) + './laboratory_work.rb'
require_relative '../../model_entity/list_file/students_list_file.rb'

class Labs_list_txt < Students_list_from_file
	
	#--------------------Test dev - Labs ------------------------
	attr_accessor :addressFile
	def initialize()
		self.addressFile = "./testfile/testfile_labs/test.txt"
	end
	#----------------------------------------------------
	def read_from_file(addressFile)
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		labs = Array.new()
		File.open(addressFile,'r') do |file|
			file.each_line do |line|
				labs.push(Laboratory_work.initialization(line.delete "\n")) if(line!="")
			end
		end
		labs
	end

	def write_to_file(addressFile,nameFile,labs)
		file = File.new("#{addressFile}/#{nameFile}","w:UTF-8")
		labs.each do |i|
			file.print("#{i.id},#{i.to_s()},#{i.tasks}\n")
		end
		file.close
	end

end