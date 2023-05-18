require_relative '../../../model_entity/list_file/entities_list_from_file.rb'

class Mark_list_txt < Entities_list_from_file
	
	#--------------------Test dev - marks ------------------------
	attr_accessor :addressFile
	def initialize()
		self.addressFile = "testfile/testfile_auto/mark/test.txt"
	end
	#----------------------------------------------------
	def read_from_file(addressFile)
		addressFile = File.dirname($0) + "/../../#{self.addressFile}" if addressFile==nil
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		marks = Array.new()
		File.open(addressFile,'r') do |file|
			file.each_line do |line|
				marks.push(Mark.initialization(line.delete "\n")) if(line!="")
			end
		end
		marks
	end

	def write_to_file(addressFile,nameFile,marks)
		file = File.new("#{addressFile}/#{nameFile}","w:UTF-8")
		marks.each do |i|
			file.print("#{i.mark}\n")
		end
		file.close
	end

end