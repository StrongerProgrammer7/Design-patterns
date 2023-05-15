require_relative '../persons/owner.rb'

class Owner_list

	#--------------------Test dev - addressFile ------------------------
	attr_accessor :addressFile
	
	def initialize(type)
		case type
    		when :json
      			self.addressFile = "testfile/testfile_owners/test.json"
    		when :yaml
      			self.addressFile = "testfile/testfile_owners/test.yaml" 
    		else
      			self.addressFile = "testfile/testfile_owners/test.txt" 
    	end	
	end
	#----------------------------------------------------
	
	def get_person(line)
		Owner.initialization(line)
	end
	
	def create_person(person)
		{
			"id"=>person.id,
			"surname"=>person.surname,
			"name"=>person.name,
			"lastname"=>person.lastname,
			"phone"=>person.phone,
			"mail"=>person.mail
		}
	end
	
	def create_line_person(person)
		"#{person.id},#{person.surname},#{person.name},#{person.lastname},#{person.get_all_contacts()}\n"
	end
end