require_relative '../persons/guard.rb'

class Guard_list

#--------------------Test dev - addressFile ------------------------
	attr_accessor :addressFile
	
	def initialize(type)
		case type
    		when :json
      			self.addressFile = "testfile/testfile_guards/test.json"
    		when :yaml
      			self.addressFile = "testfile/testfile_guards/test.yaml" 
    		else
      			self.addressFile = "testfile/testfile_guards/test.txt" 
    	end	
	end
	#----------------------------------------------------
	
	def get_person(line)
		Guard.initialization(line)
	end
	
	def create_person(person)
		{
			"id"=>person.id,
			"surname"=>person.surname,
			"name"=>person.name,
			"lastname"=>person.lastname,
			"phone"=>person.phone,
			"mail"=>person.mail,
			"exp_year"=>person.exp_year
		}
	end
	
	def create_line_person(person)
		"#{person.id},#{person.surname},#{person.name},#{person.lastname},#{person.get_all_contacts()},#{person.exp_year}\n"
	end
end