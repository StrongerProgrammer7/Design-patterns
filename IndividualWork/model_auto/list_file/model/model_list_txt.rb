require_relative '../../../../model_entity/list_file/entities_list_from_file.rb'

class Model_list_txt < Entities_list_from_file
	
	#--------------------Test dev - models ------------------------
	attr_accessor :addressFile
	def initialize()
		self.addressFile = "testfile/testfile_auto/model/test.txt"
	end
	#----------------------------------------------------
	def read_from_file(addressFile)
		addressFile = File.dirname($0) + "/../../#{self.addressFile}" if addressFile==nil
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		models = Array.new()
		File.open(addressFile,'r') do |file|
			file.each_line do |line|
				models.push(Model.initialization(line.delete "\n")) if(line!="")
			end
		end
		models
	end

	def write_to_file(addressFile,nameFile,models)
		file = File.new("#{addressFile}/#{nameFile}","w:UTF-8")
		models.each do |i|
			file.print("#{i.model},#{i.mark}\n")
		end
		file.close
	end

end