require_relative '../../model_entity/parent_entities/person.rb'

class Person_short < Person
	attr_reader :initials, :contact

	def self.initialization(person)
		raise "require class's object person" if(person.class.to_s!="Owner" and person.class.to_s!="Guard")
		Person_short.new(id:person.id,information:person.get_Info())
	end

	def to_s()
		"#{self.initials}"
	end
	
private
	attr_writer :initials, :contact

	def initialize(id:,information:)
		self.id = id
		data = information.split(",")
		self.initials = data[0]  
		self.mail = if (Person.check_mail(data[2])!=nil) then data[2] else "not mail" end
		self.contact=data[1] #delete similar space
	end
end