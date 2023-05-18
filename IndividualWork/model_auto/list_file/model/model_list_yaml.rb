require_relative '../../../../model_entity/list_file/entities_list_from_file.rb'

require 'yaml'


class Model_list_yaml < Entities_list_from_file

	#--------------------Test dev - models ------------------------
	attr_accessor :addressFile
	def initialize()
		self.addressFile =  "testfile/testfile_auto/model/test.yaml"
	end
	#----------------------------------------------------

	def read_from_file(addressFile)
		addressFile = File.dirname($0) + "/../../#{self.addressFile}" if addressFile==nil
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		
		models = Array.new()
		models_hash = YAML.load_file(addressFile)
		models_hash.each do |key, model|
			line = ""
			model.each do |key_fields, elem|
				line+= elem + "," if(elem!=nil)
			end
			line.delete_suffix! ","
			models.push(Model.initialization(line)) if(line!="")
		end		
		models
	end

	def write_to_file(addressFile,nameFile,models)
		file = File.new("#{addressFile}/#{nameFile}.yaml","w:UTF-8")
		models_hash = {}
		num = 1
		models.each do |i|
			models_hash["model#{num}"] = {
				"model" => i.model,
				"mark" => i.mark
			}
			num+=1
		end
		file.write(models_hash.to_yaml)
		file.close
	end

end 