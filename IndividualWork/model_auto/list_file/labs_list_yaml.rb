require_relative File.dirname($0) + './laboratory_work.rb'
require_relative '../../model_entity/list_file/students_list_file.rb'

require 'yaml'


class Labs_list_yaml < Students_list_from_file

	#--------------------Test dev - Labs ------------------------
	attr_accessor :addressFile
	def initialize()
		self.addressFile =  "./testfile/testfile_labs/test.yaml"
	end
	#----------------------------------------------------

	def read_from_file(addressFile)
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		
		labs = Array.new()
		labs_hash = YAML.load_file(addressFile)
		labs_hash.each do |key, lab|
			line = ""
			lab.each do |key_fields, elem|
				line+= elem + "," if(elem!=nil)
			end
			line.delete_suffix! ","
			labs.push(Laboratory_work.initialization(line)) if(line!="")
		end		
		labs
	end

	def write_to_file(addressFile,nameFile,labs)
		file = File.new("#{addressFile}/#{nameFile}.yaml","w:UTF-8")
		lab_hash = {}
		number_lab = 1
		labs.each do |i|
			lab_hash["student#{number_lab}"] = {
				"id" => i.id,
				"name"=>i.name,
				"topics"=>i.topics,
				"tasks"=>i.tasks,
				"date"=>i.date,
				"number"=>i.number
			}
			number_lab+=1
		end
		file.write(lab_hash.to_yaml)
		file.close
	end

end 