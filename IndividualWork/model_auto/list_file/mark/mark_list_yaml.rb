require_relative '../../../model_entity/list_file/entities_list_from_file.rb'

require 'yaml'


class Mark_list_yaml < Entities_list_from_file

	#--------------------Test dev - marks ------------------------
	attr_accessor :addressFile
	def initialize()
		self.addressFile =  "testfile/testfile_auto/mark/test.yaml"
	end
	#----------------------------------------------------

	def read_from_file(addressFile)
		addressFile = File.dirname($0) + "/../../#{self.addressFile}" if addressFile==nil
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		
		marks = Array.new()
		marks_hash = YAML.load_file(addressFile)
		marks_hash.each do |key, mark|
			line = ""
			mark.each do |key_fields, elem|
				line+= elem + "," if(elem!=nil)
			end
			line.delete_suffix! ","
			marks.push(Mark.initialization(line)) if(line!="")
		end		
		marks
	end

	def write_to_file(addressFile,nameFile,marks)
		file = File.new("#{addressFile}/#{nameFile}.yaml","w:UTF-8")
		model_hash = {}
		num = 1
		marks.each do |i|
			model_hash["mark#{num}"] = {
				"mark" => i.mark
			}
			num+=1
		end
		file.write(model_hash.to_yaml)
		file.close
	end

end 