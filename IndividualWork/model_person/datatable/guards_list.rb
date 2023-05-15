require_relative File.dirname($0) + './datatable/persons_list.rb'

class Guards_list < Persons_list
	
	def initialize(format_file)
		super(format_file)
	end
	
	private 
		def get_person(element)
			person = Guard.new(id:element["id"],surname:element["surname"],name:element["name"],lastname:element["lastname"],phone:element["phone"],mail:element["mail"],exp_year:hash_data["exp_year"])
		end	
	
end