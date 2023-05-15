require_relative File.dirname($0) + './datatable/persons_list.rb'

class Owners_list < Persons_list
	
	def initialize(format_file)
		super(format_file)
	end
	
	private 
	
		def get_person(element)
			person = Owner.new(id:element["id"],surname:element["surname"],name:element["name"],lastname:element["lastname"],phone:element["phone"],mail:element["mail"])
		end	
	
end