require_relative '../../model_entity/list_file/entities_list_from_file.rb'

require 'json'


class Auto_list_json < Entities_list_from_file
	
	#--------------------Test dev - Labs ------------------------
	attr_accessor :addressFile
	def initialize()
		self.addressFile = "testfile/testfile_auto/test.json"
	end
	#----------------------------------------------------

	def read_from_file(addressFile)
		addressFile = File.dirname($0) + "/../../#{self.addressFile}" if addressFile==nil
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		autos = Array.new()
		file = File.read addressFile
		auto_hash = JSON.parse(file)
		auto_hash.each do |key, auto|
			line = ""
			auto.each do |key_fields, elem|
				line+= elem.to_s + "," if(elem!=nil)
			end
			line.delete_suffix! ","
			autos.push(Auto.initialization(line)) if(line!="")
		end		
		autos
	end

	def write_to_file(addressFile,nameFile,auto)
		file = File.new("#{File.dirname($0)}#{addressFile}/#{nameFile}.json","w:UTF-8")
		auto_hash = {}
		num = 1
		auto.each do |i|
			auto_hash["auto#{num}"] = {
				"id" => i.id,
				"id_owner"=>i.id_owner,
				"surname_owner"=>i.surname_owner,
				"model"=>i.model,
				"color"=>i.color
			}
			num+=1
		end
		file.write(JSON.pretty_generate(auto_hash))
		file.close
	end

end