require_relative '../../../model_entity/list_file/entities_list_from_file.rb'

require 'json'


class Mark_list_json < Entities_list_from_file
	
	#--------------------Test dev - Labs ------------------------
	attr_accessor :addressFile
	def initialize()
		self.addressFile = "testfile/testfile_auto/mark/test.json"
	end
	#----------------------------------------------------

	def read_from_file(addressFile)
		addressFile = File.dirname($0) + "/../../#{self.addressFile}" if addressFile==nil
		raise "Address file don't correct, check this." if(!File.exist?(addressFile))
		marks = Array.new()
		file = File.read addressFile
		mark_hash = JSON.parse(file)
		mark_hash.each do |key, mark|
			line = ""
			mark.each do |key_fields, elem|
				line+= elem.to_s + "," if(elem!=nil)
			end
			line.delete_suffix! ","
			marks.push(Mark.initialization(line)) if(line!="")
		end		
		marks
	end

	def write_to_file(addressFile,nameFile,mark)
		file = File.new("#{File.dirname($0)}#{addressFile}/#{nameFile}.json","w:UTF-8")
		mark_hash = {}
		num = 1
		mark.each do |i|
			mark_hash["mark#{num}"] = {
				"mark" => i.mark
			}
			num+=1
		end
		file.write(JSON.pretty_generate(mark_hash))
		file.close
	end

end