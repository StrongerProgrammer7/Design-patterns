require_relative '../../../model_entity/list_file/entities_list_from_file.rb'

require 'json'


class Model_list_json < Entities_list_from_file
	
	#--------------------Test dev - Labs ------------------------
	attr_accessor :addressFile
	def initialize()
		self.addressFile = "testfile/testfile_auto/model/test.json"
	end
	#----------------------------------------------------

	def read_from_file(addressFile)
		addressFile = File.dirname($0) + "/../../#{self.addressFile}" if addressFile==nil
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		models = Array.new()
		file = File.read addressFile
		model_hash = JSON.parse(file)
		model_hash.each do |key, model|
			line = ""
			model.each do |key_fields, elem|
				line+= elem.to_s + "," if(elem!=nil)
			end
			line.delete_suffix! ","
			models.push(Model.initialization(line)) if(line!="")
		end		
		models
	end

	def write_to_file(addressFile,nameFile,model)
		file = File.new("#{File.dirname($0)}#{addressFile}/#{nameFile}.json","w:UTF-8")
		model_hash = {}
		num = 1
		model.each do |i|
			model_hash["model#{num}"] = {
				"model" => i.model,
				"mark" => i.mark
			}
			num+=1
		end
		file.write(JSON.pretty_generate(model_hash))
		file.close
	end

end