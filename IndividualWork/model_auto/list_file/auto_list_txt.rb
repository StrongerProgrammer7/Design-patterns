require_relative '../../model_entity/list_file/entities_list_from_file.rb'

class Auto_list_txt < Entities_list_from_file
	
	#--------------------Test dev - autos ------------------------
	attr_accessor :addressFile
	def initialize()
		self.addressFile = "./testfile/testfile_auto/test.txt"
	end
	#----------------------------------------------------
	def read_from_file(addressFile)
		addressFile = self.addressFile if (addressFile == nil)
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		autos = Array.new()
		File.open(addressFile,'r') do |file|
			file.each_line do |line|
				autos.push(Auto.initialization(line.delete "\n")) if(line!="")
			end
		end
		autos
	end

	def write_to_file(addressFile,nameFile,autos)
		file = File.new("#{addressFile}/#{nameFile}","w:UTF-8")
		autos.each do |i|
			file.print("i.id,#{i.get_info()}\n")
		end
		file.close
	end

end