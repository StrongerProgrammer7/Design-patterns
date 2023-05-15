require_relative '../../model_entity/list_file/entities_list_from_file.rb'

require 'yaml'


class Auto_list_yaml < Entities_list_from_file

	#--------------------Test dev - autos ------------------------
	attr_accessor :addressFile
	def initialize()
		self.addressFile =  "./testfile/testfile_auto/test.yaml"
	end
	#----------------------------------------------------

	def read_from_file(addressFile)
		addressFile = self.addressFile if (addressFile == nil)
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		
		autos = Array.new()
		autos_hash = YAML.load_file(addressFile)
		autos_hash.each do |key, auto|
			line = ""
			auto.each do |key_fields, elem|
				line+= elem + "," if(elem!=nil)
			end
			line.delete_suffix! ","
			autos.push(Auto.initialization(line)) if(line!="")
		end		
		autos
	end

	def write_to_file(addressFile,nameFile,autos)
		file = File.new("#{addressFile}/#{nameFile}.yaml","w:UTF-8")
		auto_hash = {}
		num = 1
		autos.each do |i|
			auto_hash["auto#{num}"] = {
				"id" => i.id,
				"id_owner"=>i.id_owner,
				"model"=>i.model,
				"color"=>i.color
			}
			num+=1
		end
		file.write(auto_hash.to_yaml)
		file.close
	end

end 