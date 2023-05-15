require_relative '../../model_entity/list_file/entities_list_from_file.rb'

require 'json'


class Persons_list_json < Entities_list_from_file
		
	def initialize(person:)
		@person = person
	end
	
	def read_from_file(addressFile)
		addressFile = File.dirname($0) + "/../../#{@person.addressFile}" if addressFile==nil #Fot test
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		
		persons = Array.new()
		file = File.read addressFile
		persons_hash = JSON.parse(file)

		persons_hash.each do |key, person|
			line = ""
			person.each do |key_fields, elem|
				line+= elem.to_s + "," if(elem!=nil)
			end
			line.delete_suffix! ","
			persons.push(@person.get_person(line)) if(line!="")
		end		
		persons
	end

	def write_to_file(addressFile,nameFile,persons)
		file = File.new("#{File.dirname($0)}#{addressFile}/#{nameFile}.json","w:UTF-8")
		print "#{File.dirname($0)}#{addressFile}/#{nameFile}.json","\n"
		persons_hash = {}
		number_person = 1
		persons.each do |i|
			persons_hash["person#{number_person}"] = @person.create_person(i)
			number_person+=1
		end
		file.write(JSON.pretty_generate(persons_hash))
		file.close
	end
	
end