require_relative '../../model_entity/list_file/entities_list_from_file.rb'

require 'yaml'

class Persons_list_yaml < Entities_list_from_file

	def initialize(person:)
		@person = person
	end
	
	def read_from_file(addressFile)
		addressFile = File.dirname($0) + "/../../#{@person.addressFile}"  if addressFile==nil #Fot test
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		
		persons = Array.new()
		persons_hash = YAML.load_file(addressFile)
		persons_hash.each do |key, person|
			line = ""
			person.each do |key_fields, elem|
				line+= elem + "," if(elem!=nil)
			end
			line.delete_suffix! ","
			persons.push(@person.get_person(line)) if(line!="")
		end		
		persons
	end

	def write_to_file(addressFile,nameFile,persons)
		file = File.new("#{addressFile}/#{nameFile}.yaml","w:UTF-8")
		person_hash = {}
		number_person = 1
		persons.each do |i|
			person_hash["student#{number_person}"] = @person.create_person(i)
			number_person+=1
		end
		file.write(person_hash.to_yaml)
		file.close
	end

end